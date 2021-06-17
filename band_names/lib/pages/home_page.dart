import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'package:band_names/services/socket_service.dart';
import 'package:band_names/models/band_model.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = [];
  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('activeBands', _handleActiveBands);
    super.initState();
  }

  _handleActiveBands(dynamic bands) {
    this.bands = (bands as List)
        .map((band) => BandModel.fromMap(band))
        .toList();
    
    setState(() {});
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('activeBands');
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Band Names'),
        backgroundColor: Colors.green,
        elevation: 1,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
              ? Icon(Icons.check_circle)
              : Icon(Icons.wifi_off),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          _showGraph(),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: bands.length,
              itemBuilder: (context, i) => _bandTile(bands[i])
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addNewBand,
        elevation: 1,
      ),
    );
  }

  Widget _bandTile(BandModel band) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => socketService.emit('deleteBand', band.id),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: EdgeInsets.only(right: 10.0),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${ band.votes }', style: TextStyle(fontSize: 20.0)),
        onTap: () => socketService.emit('voteBand', band.id),
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();
    if( Platform.isAndroid ) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('New band name:'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              child: Text('Add'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addBandToList(textController.text),
            )
          ],
        )
      );
    }
    showDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog( 
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text('New band name:'),
        ),
        content: CupertinoTextField(
          controller: textController,
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Add'),
            onPressed: () => addBandToList(textController.text),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Dismiss'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      )
    );
  }

  void addBandToList(String name) {
    if(name.length > 1) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.emit('addBand', name);
    }
    Navigator.pop(context);
  }

  Widget _showGraph() {
    Map<String, double> dataMap = new Map();
    
    bands.forEach((band) {
        dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
    });

    return Container(
      
      width: double.infinity,
      height: 250,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: PieChart(
            dataMap: (bands.length > 0) ? dataMap : { 'Bands': 0.0 },
            chartType: ChartType.ring,
            chartLegendSpacing: 40,
            animationDuration: Duration(milliseconds: 1000),        
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
          ),
        ),
      ),
    );
  }
}