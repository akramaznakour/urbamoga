import 'package:equinox/equinox.dart' hide Colors;
import 'package:flutter/material.dart';

import 'package:urbamoga/models/Projet.dart';

class ResultatItem extends StatelessWidget {
  final Projet projet;

  const ResultatItem({
    Key key,
    @required this.projet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: EqCard(
        statusAppearance: EqCardStatusAppearance.header,
        shape: EqWidgetShape.semiRound,
        child: Column(
          children: _buildAttributes(context),
        ),
      ),
    );
  }

  List<Widget> _buildAttributes(context) {
    List<Widget> list = List();

    projet.toJson().forEach((key, value) {
      key = key
              .split("_")
              .join(" ")
              .split("-")
              .join(" ")
              .split(" ")
              .sublist(1)
              .join(" ")
              .substring(0, 1)
              .toUpperCase() +
          key
              .split("_")
              .join(" ")
              .split("-")
              .join(" ")
              .split(" ")
              .sublist(1)
              .join(" ")
              .substring(1);
      value = value;
      list.add(
        Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: EqText(
                    key,
                    eqStyle: EqTextStyle.label,
                    status: EqWidgetStatus.primary,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: EqText(
                    (value == "" || value == null) ? "-" : value,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    eqStyle: EqTextStyle.caption2,
                  ),
                ),
              ],
            )),
      );
    });

    return list;
  }
}
