import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/my_location/my_location_bloc.dart';


class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  
  @override
  void initState() {
    BlocProvider.of<MyLocationBloc>(context).startTracking();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MyLocationBloc>(context).disposeTracking();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyLocationBloc, MyLocationState>(
        builder: ( _ , state) => createMap(state)
      ),
    );
  }

  Widget createMap(MyLocationState state) {
    if(!state.existLocation) return Center(child: Text('Tracking...'));

    final cameraPosition = new CameraPosition(
      target: state.location!,
      zoom: 15
    );
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
    );
  }
}