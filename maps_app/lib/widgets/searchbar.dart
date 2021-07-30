part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  
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
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: size.width,
        height: 65,
        child: GestureDetector(
          onTap: () async {
            final proximity = BlocProvider.of<MyLocationBloc>(context).state.location;
            final SearchDestinationsResult? result = await showSearch(context: context, delegate: SearchDestination(proximity!));
            returnSearching(context, result!);
          },
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: <BoxShadow>[
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
                  padding: EdgeInsets.only(left: 5),
                  child: Text('¿A dónde quieres ir?', 
                    style: TextStyle(fontSize: 18)
                  )
                ),
                Icon(Icons.search)
              ],
            ),
          ),
        )
      ),
    );
  }

  void returnSearching(BuildContext context, SearchDestinationsResult result ) {
    if( result.cancel ) return;
    
    if( result.manually! ) {
      BlocProvider.of<SearchingBloc>(context).add(OnActivateManualMarker());
      return;
    }

    print(result.manually);
  }

}