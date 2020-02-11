import 'package:flutter/material.dart';

import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    
    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        
        if(!snapshot.hasData){
          return Center(
            child: CirlcularProgressIndicator(),
          );
        }

        final scnas = snapshot.data;

        if(scnas.length == 0){
           return Center(
            child: Text('No hay Informacion'),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container (color: Colors.red),
            onDissmissed: (direction) => scansBloc.borrarScan(scans[i].id),
            child: ListiTile(
              leaning: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
              title: Text(scans[i].valor),
              subtitle: Text('ID: ${scans[i].id}'),
              trailing: Icon(Icons.keyboard_arrow_rigth, color: Colors.grey),
              onTap: ()=> utils.abrirScan(context, scan[i]),
            ),
          )
        );
      },
    );
  }
}