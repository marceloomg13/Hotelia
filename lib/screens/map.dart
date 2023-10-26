import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatefulWidget {
  final double lat;
  final double long;
  const map({Key? key, required this.lat, required this.long}) : super(key: key);

  @override
  _mapState createState() => _mapState();

}

class _mapState extends State<map> {
  late GoogleMapController mapController;
  LatLng _center = LatLng(0,0);
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_center.toString()),
        position: _center,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      print(_center);
    });
  }

  @override
  Widget build(BuildContext context) {
    _center=LatLng(widget.lat.toDouble(),widget.long.toDouble());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Map Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          markers: _markers,

          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}