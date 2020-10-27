import 'package:equinox/equinox.dart' hide Colors;

import 'package:flutter/material.dart';
import 'package:urbamoga/services/auApi.dart';

import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import 'package:urbamoga/models/Canvas.dart';

import 'package:urbamoga/screens/statistiques/components/chart_page.dart';

import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;

class Statistiques extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: getStatistiques(),
          builder: (context, snapShot) {
            if (snapShot.data == null)
              if (snapShot.connectionState == ConnectionState.done) {
                return _buildConnectionError();
              } else {
                return _buildLoading();
              } else
              return _buildChartsCardList(snapShot, context);
          },
        ));
  }

  Widget _buildLoading() =>
      Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Loading(indicator: BallPulseIndicator(), size: 50.0),
          ),
        ),
      );

  Widget _buildConnectionError() =>
      Container(
        child: Center(
          child: Text(
            "verifier votre connexion internet et réessayer",
            textAlign: TextAlign.center,
          ),
        ),
      );

  Widget _buildChartsCardList(AsyncSnapshot canvasesSnap, context) =>
      Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Center(
              child: EqCard(
                status: EqWidgetStatus.primary,
                shape: EqWidgetShape.semiRound,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 3,
                      child: ListView.builder(
                          itemCount: canvasesSnap.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              child: EqButton.outline(
                                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width>400 ? 10 : 8),
                                status: EqWidgetStatus.info,
                                label: Text(
                                  canvasesSnap.data[index].title.toString()
                                      .replaceAll("\\", " "),
                                  style: TextStyle(fontSize:MediaQuery.of(context).size.width>400 ? (MediaQuery.of(context).size.width>600 ? 14 : 12) : 10),
                                ),
                                onTap: () =>
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChartPage(
                                                  canvas: canvasesSnap
                                                      .data[index])),
                                    ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
