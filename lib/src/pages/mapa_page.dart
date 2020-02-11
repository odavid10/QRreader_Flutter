import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:qrreader/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();
  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {
    
    final ScanModel scan = new ModalRoute.of(contect).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenada QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(scan.getLatLng(), 15);
            },
          ),
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearBotonFlotante(BuildContext context){
    return floatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor. Theme.of(context).primaryColor,
      onPressed: (){
        if(tipoMapa == 'streets'){
          tipoMapa = 'dark';
        }else if(tipoMapa == 'dark'){
          tipoMapa = 'light';
        }else if(tipoMapa == 'light'){
          tipoMapa = 'outdoors';
        }else if(tipoMapa == 'outdoors'){
          tipoMapa = 'satellite';
        }else{
          tipoMapa = 'streets';
        }
        setState((){});
      },
    );
  }

  Widget _crearFlutterMap (ScanModel scan){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers[
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additonalOptions: {
        'accesssToken' : 'pk.eyJ1Ijoib2RhdmlkMTAiLCJhIjoiY2s2aDN5dG93MnE1bzNrcGptYTd6bm5zNyJ9.uNSgXDKQ9F7kkCPPDWaJFw'
        'id' : 'mapbox.$tipoMapa' 
        //streets, dark, light, outdoors, satellite
      }
    );
  }

  _crearMarcadores(ScanModel scan){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on, 
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

}