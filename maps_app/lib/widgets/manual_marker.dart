part of 'widgets.dart';

class ManualMarker extends StatelessWidget {
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
            duration: Duration( milliseconds:  150 ),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon( Icons.arrow_back, color: Colors.black87),
                onPressed: () => BlocProvider.of<SearchingBloc>(context).add(OnDeactivateManualMarker()),
              )
            ),
          )
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -18),
            child: BounceInDown(
              from: 200,
              child: Icon( Icons.location_on, size: 50)
            )
          )
        ),

        Positioned(
          bottom: 70,
          left: 30,
          child: FadeIn(
            duration: Duration(milliseconds: 700),
            child: MaterialButton(
              minWidth: width - 120,
              height: 45,
              child: Text('Confirm destination', style: TextStyle( color: Colors.white, fontSize: 16 )),
              color: Colors.black,
              elevation: 0,
              splashColor: Colors.transparent,
              shape: StadiumBorder(),
              onPressed: () {
                this.calculateDestination(context);
              },
            ),
          ),
        )
      ],
    );
  }

  void calculateDestination(BuildContext context) async {
    final trafficService = new TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final origin = BlocProvider.of<MyLocationBloc>(context).state.location; 
    final destination = BlocProvider.of<MapBloc>(context).state.centralLocation;

    final trafficResponse = await trafficService.getStartAndFinalCoords(origin!, destination);

    final geometry = trafficResponse.routes![0].geometry;
    final distance = trafficResponse.routes![0].distance;
    final duration = trafficResponse.routes![0].duration;

    final points = decodePolyline(geometry!, accuracyExponent: 6);
    final List<LatLng> routeCoords = points.map(
      (coords) => LatLng(coords[0].toDouble(), coords[1].toDouble())
    
    ).toList();
    
    mapBloc.add(OnCreateRouteOriginDestination(routeCoords, distance!, duration!));

  }
}