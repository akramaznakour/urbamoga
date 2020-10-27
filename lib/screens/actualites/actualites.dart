/// UI libraries
import 'package:equinox/equinox.dart' hide Colors;

/// flutter libraries
import 'package:flutter/material.dart';

/// Screens Components
import 'package:urbamoga/screens/actualites/components/actualite_item.dart';

/// Widgets libraries
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

/// Api services
import 'package:urbamoga/services/auApi.dart';

/// Actualites screen Widget
class Actualites extends StatelessWidget {
  const Actualites({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 8),
      child: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 160,
            child: _buildActualitesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActualitesList() => FutureBuilder(
      future: getActualites(),
      builder: (BuildContext context, AsyncSnapshot actualitesSnap) {
        if (actualitesSnap.data == null) {
          if (actualitesSnap.connectionState == ConnectionState.done) {
            return _buildConnectionError();
          } else {
            return _buildLoading();
          }
        } else {
          return Container(
            child: ListView.builder(
                itemCount: actualitesSnap.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: ActualiteItem(actualite: actualitesSnap.data[index]),
                  );
                }),
          );
        }
      });

  Widget _buildLoading() => Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Loading(indicator: BallPulseIndicator(), size: 50.0),
          ),
        ),
      );

  Widget _buildConnectionError() => Container(
        child: Center(
          child: Text(
            "aucune actualite n'a été trouvée. \n\n verifier votre connexion internet et réessayer",
            textAlign: TextAlign.center,
          ),
        ),
      );
}
