import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// UI libraries
import 'package:equinox/equinox.dart' hide Colors;

class Cart extends StatefulWidget {
  @override
  CartState createState() => CartState();
}

class CartState extends State<Cart> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.4;

  @override
  Widget build(BuildContext context) {
    return EqLayout(
        appBar: EqAppBar(
          title: "Cart",
          actions: <Widget>[_zoomplusfunction(), _zoomminusfunction()],
        ),
        child: Stack(
          children: <Widget>[
            _buildGoogleMap(context),
            _buildContainer(),
          ],
        ));
  }

  Widget _zoomminusfunction() {
    return IconButton(
        icon: Icon(Icons.zoom_out),
        onPressed: () {
          zoomVal--;
          _minus(zoomVal);
        });
  }

  Widget _zoomplusfunction() {
    return IconButton(
        icon: Icon(Icons.zoom_in),
        onPressed: () {
          zoomVal++;
          _plus(zoomVal);
        });
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(31.7218664, -11.6449272), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(31.7218664, -11.6449272), zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        height: 80.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: ausMarkers
              .map((markerInfo) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _boxes(
                        markerInfo["latLng"][0],
                        markerInfo["latLng"][1],
                        markerInfo['title']),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _boxes( double lat, double long, String agenceName) {
    return Center(
        child: EqButton.outline(
      padding: EdgeInsets.all(20),
      label: EqText(
        agenceName,
        eqStyle: EqTextStyle.caption1,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      status: EqWidgetStatus.info,
      shape: EqWidgetShape.round,
      onTap: () {
        _gotoLocation(lat, long);
      },
    ));
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(31.4969208, -9.7588635), zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: ausMarkers
            .map((markerInfo) => Marker(
                  markerId: MarkerId(markerInfo['id']),
                  position:
                      LatLng(markerInfo['latLng'][0], markerInfo['latLng'][1]),
                  infoWindow: InfoWindow(title: markerInfo['title']),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                ))
            .toSet(),
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
       bearing: 45.0,
    )));
  }
}

List ausMarkers = [
  {
    'id': 'Essaouira',
    'latLng': [31.4969208, -9.7588635],
    'title': "Agence Urbaine de Essaouira ",
  },
  {
    'id': 'Marrakech',
    'latLng': [31.6300534, -8.0154164],
    'title': "Agence Urbaine de Marrakech ",
  },
  {
    'id': 'RabatSale',
    'latLng': [33.9539792, -6.8751115],
    'title': "Agence Urbaine de Rabat-Salé ",
  },
  {
    'id': 'Safi',
    'latLng': [32.2941505, -9.2348249],
    'title': "Agence Urbaine de Safi  ",
  },
  {
    'id': 'Casablanca',
    'latLng': [33.5916208, -7.6245399],
    'title': "Agence Urbaine de Casablanca ",
  },
  {
    'id': 'Tanger',
    'latLng': [35.7782785, -5.8064884],
    'title': "Agence urbaine de Tanger ",
  },
  {
    'id': 'Larache',
    'latLng': [35.171982, -6.1454397],
    'title': "Agence Urbaine de Larache  ",
  },
  {
    'id': 'KenitraSidiKacem',
    'latLng': [34.2526214, -6.5990922],
    'title': "Agence Urbaine de Kénitra-Sidi Kacem ",
  },
  {
    'id': 'SkhirateTemara',
    'latLng': [33.9331624, -6.9104081],
    'title': "Agence Urbaine de Skhirate-Témara ",
  },
  {
    'id': 'Berrechid',
    'latLng': [33.2746733, -7.5861934],
    'title': "Agence Urbaine de Berrechid ",
  },
  {
    'id': 'Settat',
    'latLng': [32.9979833, -7.6227897],
    'title': "Agence Urbaine de Settat ",
  },
  {
    'id': 'ElJadida',
    'latLng': [33.2367974, -8.5037372],
    'title': "Agence Urbaine de El Jadida  ",
  },
  {
    'id': 'Khemisset',
    'latLng': [33.8271296, -6.0797681],
    'title': "Agence Urbaine de Khmisset ",
  },
  {
    'id': 'Tetouan',
    'latLng': [35.5879412, -5.3369345],
    'title': "Agence Urbaine de Tétouan ",
  },
  {
    'id': 'AlHoceima',
    'latLng': [35.2423765, -3.932101],
    'title': "Agence Urbaine de Al Hoceima ",
  },
  {
    'id': 'KelaadesSraghna',
    'latLng': [32.0543185, -7.410394],
    'title': "Agence Urbaine de l Kelâa des Sraghna ",
  },
  {
    'id': 'Agadir',
    'latLng': [30.4230502, -9.6014215],
    'title': "Agence Urbaine de Agadir ",
  },
  {
    'id': 'Taroudannt',
    'latLng': [30.465256, -8.8761367],
    'title': "Agence Urbaine de Taroudannt ",
  },
  {
    'id': 'GuelmimEsSmara',
    'latLng': [28.996894, -10.054799],
    'title': "Agence Urbaine de Guelmim Es-Smara ",
  },
  {
    'id': 'Laayoune',
    'latLng': [27.1497669, -13.1998805],
    'title': "Agence Urbaine de Laâyoune ",
  },
  {
    'id': 'OuedEddahabAousserd',
    'latLng': [23.7018123, -15.9338799],
    'title': "Agence Urbaine de Oued Ed-Dahab Aousserd ",
  },
  {
    'id': 'Nador',
    'latLng': [35.1772726, -2.9977137],
    'title': "Agence Urbaine de Nador ",
  },
  {
    'id': 'Oujda',
    'latLng': [34.6883697, -1.9124955],
    'title': "Agence Urbaine de Oujda ",
  },
  {
    'id': 'TazaTaounate',
    'latLng': [34.229713, -4.0099266],
    'title': "Agence Urbaine de Taza ",
  },
  {
    'id': 'Fes',
    'latLng': [34.0416395, -5.0057006],
    'title': "Agence Urbaine de Fès ",
  },
  {
    'id': 'Meknes',
    'latLng': [33.901167, -5.5503204],
    'title': "Agence Urbaine de Meknès ",
  },
  {
    'id': 'Khenifra',
    'latLng': [32.9348142, -5.6702874],
    'title': "Agence Urbaine de Khénifra ",
  },
  {
    'id': 'BeniMellal',
    'latLng': [32.334094, -6.3612103],
    'title': "Agence Urbaine de Beni Mellal ",
  },
  {
    'id': 'Errachidia',
    'latLng': [31.9319108, -4.4282292],
    'title': "Agence Urbaine de Errachidia ",
  },
  {
    'id': 'OuarzazateZagoraTinghir',
    'latLng': [30.930057, -6.9307997],
    'title': "Agence Urbaine de Ouarzazate-Zagora ",
  }
];
