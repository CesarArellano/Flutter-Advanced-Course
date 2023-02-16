import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../extensions/null_extensions.dart';
import '../models/band_model.dart';
import '../services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
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
        title: const Text('Band Names'),
        backgroundColor: Colors.green,
        elevation: 1,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.online)
              ? const Icon(Icons.check_circle)
              : const Icon(Icons.wifi_off),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          _showGraph(),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: bands.length,
              itemBuilder: (context, i) => _bandTile(bands[i])
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: addNewBand,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(BandModel band) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id ?? ''),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => socketService.emit('deleteBand', band.id),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsets.only(right: 10.0),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[500],
          child: Text(band.name.value().substring(0,2), style: const TextStyle(color: Colors.white)),
        ),
        title: Text(band.name.value()),
        trailing: Text('${ band.votes }', style: const TextStyle(fontSize: 20.0)),
        onTap: () => socketService.emit('voteBand', band.id),
      ),
    );
  }

  // Color _getRandomColor() {
  //   return Color.fromRGBO(Random().nextInt(200), Random().nextInt(200), Random().nextInt(200), 1);
  // }

  addNewBand() {
    final textController = TextEditingController();
    
    if( bands.length == 8 ) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('No se pueden agregar más bandas')
        )
      );
    }

    if( Platform.isAndroid ) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green.shade50,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8) ),
          title: const Text('New Band Name'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Band Name'
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
              ),
              onPressed: () => addBandToList(textController.text),
              child: const Text('Add'),
            ),
          ],
        )
      );
    }
    showDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog(
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text('New band name:'),
        ),
        content: CupertinoTextField(
          controller: textController,
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Add'),
            onPressed: () => addBandToList(textController.text),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Dismiss'),
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
    Map<String, double> dataMap = {};
    
    for (var band in bands) {
        dataMap.putIfAbsent(band.name.value(), () => band.votes.value().toDouble());
    }

    return SizedBox(
      
      width: double.infinity,
      height: 280,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'RESULTS:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              const SizedBox(height: 15),
              ( bands.isNotEmpty )
                ? PieChart(
                  dataMap: (bands.isNotEmpty) ? dataMap : { 'Bands': 0.0 },
                  chartType: ChartType.ring,
                  chartLegendSpacing: 40,
                  animationDuration: const Duration(milliseconds: 1000),        
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true,
                  ),
                )
                : const Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}