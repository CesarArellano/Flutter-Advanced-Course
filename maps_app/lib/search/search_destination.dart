import 'package:flutter/material.dart';

class SearchDestination extends SearchDelegate {
  @override
  final String searchFieldLabel;

  SearchDestination() : this.searchFieldLabel = 'Search...';
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
    return IconButton(
      onPressed: () => this.close(context, null),
      icon: Icon(Icons.arrow_back, color: Colors.black)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Set Location Manually'),
          onTap: () {
            print('Manually');
            this.close(context, null);
          },
        )
      ],
    );
  }

}