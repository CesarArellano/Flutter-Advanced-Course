import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';


class GpsAccessPage extends StatefulWidget {

  @override
  _GpsAccessPageState createState() => _GpsAccessPageState();
}

class _GpsAccessPageState extends State<GpsAccessPage> with WidgetsBindingObserver {
  
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if( state == AppLifecycleState.resumed ) {
      if( await Permission.location.isGranted ) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/gps_permission2.svg', width: 200),
            SizedBox(height: 20),
            Text('You need a GPS permission to use this app', style: TextStyle(fontSize: 16.0),),
            SizedBox(height: 20),
            Container(
              width: 160,
              height: 45,
              child: MaterialButton(
                child: Text('Request access', style: TextStyle( color: Colors.white, fontSize: 16.0),),
                color: Colors.black,
                elevation: 0, 
                splashColor: Colors.transparent,
                shape: StadiumBorder(),
                onPressed: () => gpsAccess()
              ),
            ),
          ],
        )
      ),
    );
  }

  void gpsAccess() async {
    final status = await Permission.location.request();
    switch(status) {

      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context,'map');
      break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
      break;
      
    }
  }
}