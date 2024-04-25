import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/map/map_bloc.dart';
import 'package:maps_app/bloc/my_location/my_location_bloc.dart';
import 'package:maps_app/widgets/widgets.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});


  @override
  State<MapPage> createState() => _MapPageState();
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
        builder: ( _ , state) {
          return Stack(
            children: <Widget>[
              createMap(state),
              const ManualMarker(),
              const Positioned(
                top: 10,
                child: SearchBar()
              ),
            ],
          );
        }
      ),
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnLocation(),
          BtnFollowLocation(),
          BtnMyRoute(),
        ],
      ),
    );
  }

  Widget createMap(MyLocationState state) {
    if( !state.existLocation ) return const Center(child: Text('Tracking...'));

    final mapBloc = BlocProvider.of<MapBloc>(context);

    mapBloc.add( OnNewLocation(state.location!) );

    final cameraPosition = CameraPosition(
      target: state.location!,
      zoom: 15
    );

    return BlocBuilder<MapBloc, MapState>(
      builder: ( _ , state) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: mapBloc.initMap,
          polylines: mapBloc.state.polylines.values.toSet(),
          markers: mapBloc.state.markers.values.toSet(),
          onCameraMove: ( cameraPosition ) {
            mapBloc.add( OnMovedMap(cameraPosition.target) );
          },
          // onCameraIdle: () { When the moving camera stop it, call this fuction;
          //   print('Idle Map');
          // },
        );
      },
    );
  }
}