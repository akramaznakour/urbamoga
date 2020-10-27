/// UI libraries
import 'package:equinox/equinox.dart' hide Colors;

/// flutter libraries
import 'package:flutter/material.dart';


/// Api services
import 'package:urbamoga/services/auApi.dart';

import 'package:urbamoga/models/Projet.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:urbamoga/screens/resultats_commissions/components/resultat_item.dart';

class ResultatsPage extends StatelessWidget {
  final String type;
  final String critereDeRecherche;

  final String critereDeRechercheValue;

  const ResultatsPage(
      {Key key,
      this.type,
      this.critereDeRecherche,
      this.critereDeRechercheValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EqLayout(
      appBar: EqAppBar(
        title: "Resultats de la Recherche",
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 120,
              child: FutureBuilder(
                  future: searchResultatsCommissions(
                      critereDeRecherche: this.critereDeRecherche,
                      critereDeRechercheValue: this.critereDeRechercheValue,
                      type: this.type),
                  builder:
                      (BuildContext context, AsyncSnapshot actualitesSnap) {
                    if (actualitesSnap.data == null) {
                      if (actualitesSnap.connectionState ==
                          ConnectionState.done) {
                        return Container(
                          child: Center(
                            child: Text(
                                "aucun résultat ne correspond à votre recherche."),
                          ),
                        );
                      } else {
                        return _buildLoading();
                      }
                    } else {
                      return Container(
                        child: ListView.builder(
                            itemCount: actualitesSnap.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: ResultatItem(
                                    projet: Projet(
                                        architecte: actualitesSnap
                                            .data[index].architecte,
                                        type: actualitesSnap.data[index].type,
                                        dateDeLaCommission: actualitesSnap
                                            .data[index].dateDeLaCommission,
                                        avisDeLaCommission: actualitesSnap
                                            .data[index].avisDeLaCommission,
                                        commune:
                                            actualitesSnap.data[index].commune,
                                        natureDuProjet: actualitesSnap
                                            .data[index].natureDuProjet,
                                        situationDuProjet: actualitesSnap
                                            .data[index].situationDuProjet,
                                        proprietaire: actualitesSnap
                                            .data[index].proprietaire,
                                        numeroDeDossier: actualitesSnap
                                            .data[index].numeroDeDossier,
                                        postType:
                                            actualitesSnap.data[index].postType,
                                        observation: actualitesSnap
                                            .data[index].observation)),
                              );
                            }),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() => Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Loading(indicator: BallPulseIndicator(), size: 50.0),
          ),
        ),
      );
}
