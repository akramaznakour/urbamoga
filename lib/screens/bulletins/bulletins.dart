/// UI libraries
import 'package:equinox/equinox.dart' hide Colors;

/// flutter libraries
import 'package:flutter/material.dart';

/// Screens Components
import 'package:urbamoga/screens/bulletins/components/bulletin_item.dart';

/// Widgets libraries
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

/// Api services
import 'package:urbamoga/services/auApi.dart';

/// Bulletins screen Widget
class Bulletins extends StatelessWidget {
  const Bulletins({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 170,
            child: _buildBulletinsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletinsList() => FutureBuilder(
      future: getBulletins(),
      builder: (BuildContext context, AsyncSnapshot bulletinsSnap) {
        if (bulletinsSnap.data == null) {
          if (bulletinsSnap.connectionState == ConnectionState.done) {
            return _buildConnectionError();
          } else {
            return _buildLoading();
          }
        } else {
          return Container(
            child: ListView.builder(
                itemCount: bulletinsSnap.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: BulletinItem(bulletin: bulletinsSnap.data[index]),
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
        "aucun bulletin n'a été trouvé. \n\n verifier votre connexion internet et réessayer",
        textAlign: TextAlign.center,
      ),
    ),
  );
}
