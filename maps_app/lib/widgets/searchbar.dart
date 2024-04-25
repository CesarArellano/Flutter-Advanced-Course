part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchingBloc, SearchingState>(
      builder: ( _, state) {
        if(!state.manualSelection) {
          return FadeInDown(
            child: _searchbarBuild(context)
          );
        } else {
          return Container();
        }
      },

    );
  }
  
  Widget _searchbarBuild(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: size.width,
        height: 65,
        child: GestureDetector(
          onTap: () async {
            final proximity = BlocProvider.of<MyLocationBloc>(context).state.location;
            final history = BlocProvider.of<SearchingBloc>(context).state.history;
            final SearchDestinationsResult? result = await showSearch(context: context, delegate: SearchDestination(proximity!, history));
            // ignore: use_build_context_synchronously
            returnSearching(context, result!);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 3)
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: const Text('¿A dónde quieres ir?', 
                    style: TextStyle(fontSize: 18)
                  )
                ),
                const Icon(Icons.search)
              ],
            ),
          ),
        )
      ),
    );
  }

  Future<void> returnSearching(BuildContext context, SearchDestinationsResult result ) async {
    if( result.cancel ) return;
    
    if( result.manually! ) {
      BlocProvider.of<SearchingBloc>(context).add(OnActivateManualMarker());
      return;
    }

    // Calculate route based in SearchDelegate Value.
    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    
    final origin = BlocProvider.of<MyLocationBloc>(context).state.location;
    final destination = result.position;

    final drivingResponse = await trafficService.getStartAndFinalCoords(origin!, destination!);
    
    final geometry = drivingResponse.routes![0].geometry;
    final distance = drivingResponse.routes![0].distance;
    final duration = drivingResponse.routes![0].duration;
    final destinationName = result.destinationName;

    final points = decodePolyline(geometry!, accuracyExponent: 6);
    final List<LatLng> routeCoords = points.map(
      (coords) => LatLng(coords[0].toDouble(), coords[1].toDouble())
    ).toList();
    
    if ( !context.mounted ) return;
    mapBloc.add(OnCreateRouteOriginDestination(routeCoords, distance!, duration!, destinationName!));
    final searchingBloc = BlocProvider.of<SearchingBloc>(context);
    searchingBloc.add( OnAddHistory( result ));

  }

}