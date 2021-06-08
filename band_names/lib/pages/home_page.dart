import 'package:flutter/material.dart';
import 'package:band_names/models/band_model.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = [
    BandModel(id: '1', name: 'Siddhartha', votes: 5),
    BandModel(id: '2', name: 'Technicolor Fabrics', votes: 35),
    BandModel(id: '3', name: 'Camilo Séptimo', votes: 45),
    BandModel(id: '4', name: 'Daft Punk', votes: 25),
    BandModel(id: '5', name: 'Odisseo', votes: 95),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length, 
        itemBuilder: (context, i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        elevation: 1,
      ),
    );
  }

  ListTile _bandTile(BandModel band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.name.substring(0,2)),
        backgroundColor: Colors.blue[100],
      ),
      title: Text(band.name),
      trailing: Text('${ band.votes }', style: TextStyle(fontSize: 20.0)),
      onTap: () {},
    );
  }
}