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
    this.searchFieldLabel = 'Search...',
    this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [ 
      IconButton(
        onPressed: () => this.query = '',
        icon: Icon(Icons.clear, color: Colors.black)
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final searchResult = new SearchDestinationsResult(cancel: true);

    return IconButton(
      onPressed: () => this.close(context, searchResult),
      icon: Icon(Icons.arrow_back, color: Colors.black)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return _buildingResultsSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if( this.query.length == 0) {
      final searchResult = new SearchDestinationsResult(cancel: false, manually: true);
      return ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Set Location Manually'),
            onTap: () {
              this.close(context, searchResult);
            },
          ),
          ...this.history.map(
            (place) =>  ListTile(
              leading: Icon(Icons.history),
              title: Text(place.destinationName!),
              subtitle: Text(place.description!),
              onTap: () {
                this.close(context, place );
              },
            )
          ).toList()

        ],
      );
    }

    return this._buildingResultsSuggestions(context);
    
  }

  Widget _buildingResultsSuggestions(BuildContext context) {
    
    if ( this.query.length == 0) {
      return Container();
    }
    
    this._trafficService.getSuggestionsByQuery( this.query.trim(), proximity );
    
    return StreamBuilder(
      stream: this._trafficService.suggestionsStream,
      builder: ( _ , AsyncSnapshot<dynamic> snapshot) {
        if ( !snapshot.hasData ) {
          return Center( child: CircularProgressIndicator());
        }
        
        final places = snapshot.data['features'];
        
        if ( places.length == 0) {
          return ListTile(
            title: Text('No results with $query'),
          );
        }
        return ListView.separated(
          itemCount: places.length, 
          separatorBuilder: ( _, i) => Divider(),
          itemBuilder: ( _, i)  {
            final place = places[i];
            return ListTile(
              leading: Icon( Icons.place ),
              title: Text(place['text_es']),
              subtitle: Text( place['place_name_es'] ),
              onTap: () {
                this.close(context, SearchDestinationsResult(
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