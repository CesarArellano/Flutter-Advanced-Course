part of 'widgets.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SearchingBloc, SearchingState>(
      builder: ( _, state) {
        if( state.manualSelection ) {
          return _ManualMarkerBuild();
        } else {
          return Container();
        }
      },
    );
    
  }
}

class _ManualMarkerBuild extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: const Duration( milliseconds:  150 ),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon( Icons.arrow_back, color: Colors.black87),
                onPressed: () => BlocProvider.of<SearchingBloc>(context).add(OnDeactivateManualMarker()),
              )
            ),
          )
        ),
        Center(
          child: Transform.translate(
            offset: const Offset(0, -18),
            child: BounceInDown(
              from: 200,
              child: const Icon( Icons.location_on, size: 50)
            )
          )
        ),

        Positioned(
          bottom: 70,
          left: 30,
          child: FadeIn(
            duration: const Duration(milliseconds: 700),
            child: MaterialButton(
              minWidth: width - 120,
              height: 45,
              color: Colors.black,
              elevation: 0,
              splashColor: Colors.transparent,
              shape: const StadiumBorder(),
              onPressed: () {
                calculateDestination(context);
              },
              child: const Text('Confirm destination', style: TextStyle( color: Colors.white, fontSize: 16 )),
            ),
          ),
        )
      ],
    );
  }

  void calculateDestination(BuildContext context) async {
    calculatingAlert(context);

    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final searchingBloc = BlocProvider.of<SearchingBloc>(context);

    final origin = BlocProvider.of<MyLocationBloc>(context).state.location; 
    final destination = BlocProvider.of<MapBloc>(context).state.centralLocation;

    final reverseQueryResponse = await trafficService.getCoordsInfo(destination);
    
    final trafficResponse = await trafficService.getStartAndFinalCoords(origin!, destination);

    final geometry = trafficResponse.routes![0].geometry;
    final distance = trafficResponse.routes![0].distance;
    final duration = trafficResponse.routes![0].duration;
    final destinationName = reverseQueryResponse.features![0].textEs;

    final points = decodePolyline(geometry!, accuracyExponent: 6);
    final List<LatLng> routeCoords = points.map(
      (coords) => LatLng(coords[0].toDouble(), coords[1].toDouble())
    ).toList();
    
    if ( !context.mounted ) return;
    mapBloc.add(OnCreateRouteOriginDestination(routeCoords, distance!, duration!, destinationName!));
    Navigator.of(context).pop();
    searchingBloc.add( OnDeactivateManualMarker() );
  }
}