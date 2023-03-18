import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/services/traffic_service.dart';
import 'package:maps_app/models/search_destinations_result.dart';

class SearchDestination extends SearchDelegate<SearchDestinationsResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximity;
  final List<SearchDestinationsResult> history;

  SearchDestination( this.proximity, this.history ) : 
    searchFieldLabel = 'Search...',
    _trafficService = TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [ 
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear, color: Colors.black)
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final searchResult = SearchDestinationsResult(cancel: true);

    return IconButton(
      onPressed: () => close(context, searchResult),
      icon: const Icon(Icons.arrow_back, color: Colors.black)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return _buildingResultsSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if( query.isEmpty) {
      final searchResult = SearchDestinationsResult(cancel: false, manually: true);
      return ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Set Location Manually'),
            onTap: () {
              close(context, searchResult);
            },
          ),
          ...history.map(
            (place) =>  ListTile(
              leading: const Icon(Icons.history),
              title: Text(place.destinationName!),
              subtitle: Text(place.description!),
              onTap: () {
                close(context, place );
              },
            )
          ).toList()

        ],
      );
    }

    return _buildingResultsSuggestions(context);
    
  }

  Widget _buildingResultsSuggestions(BuildContext context) {
    
    if ( query.isEmpty) {
      return Container();
    }
    
    _trafficService.getSuggestionsByQuery( query.trim(), proximity );
    
    return StreamBuilder(
      stream: _trafficService.suggestionsStream,
      builder: ( _ , AsyncSnapshot<dynamic> snapshot) {
        if ( !snapshot.hasData ) {
          return const Center( child: CircularProgressIndicator());
        }
        
        final places = snapshot.data['features'];
        
        if ( places.length == 0) {
          return ListTile(
            title: Text('No results with $query'),
          );
        }
        return ListView.separated(
          itemCount: places.length, 
          separatorBuilder: ( _, i) => const Divider(),
          itemBuilder: ( _, i)  {
            final place = places[i];
            return ListTile(
              leading: const Icon( Icons.place ),
              title: Text(place['text_es']),
              subtitle: Text( place['place_name_es'] ),
              onTap: () {
                close(context, SearchDestinationsResult(
                    cancel: false, 
                    manually: false,
                    position: LatLng(place['center'][1], place['center'][0]),
                    destinationName: place['text_es'],
                    description: place['place_name_es']
                  )
                );
              },
            );
          }
        );
      }
    );
  }
}