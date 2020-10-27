/// UI libraries
import 'package:equinox/equinox.dart' hide Colors;

/// flutter libraries
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Screens Components
import 'package:urbamoga/screens/resultats_commissions/components/resultat_page.dart';

/// ResultatsCommissions screen Widget
class ResultatsCommissions extends StatefulWidget {
  @override
  _ResultatsCommissionsState createState() => _ResultatsCommissionsState();
}

class _ResultatsCommissionsState extends State<ResultatsCommissions> {
  bool checked = false;

  String type = "";
  String critereDeRecherche = "";
  String critereDeRechercheValue = "";
  DateTime selectedDate;

  @override
  initState() {
    super.initState();

    selectedDate = DateTime.now();
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        child: EqCard(
          statusAppearance: EqCardStatusAppearance.header,
          shape: EqWidgetShape.semiRound,
          header: Text('Rechercher resultat de commissions '),
          child: Column(
            children: _buildFormInputs(),
          ),
          footer: EqButton(
            appearance: EqWidgetAppearance.outline,
            onTap: _rechercheButtonFunction,
            label: Text('Rechercher'),
            size: EqWidgetSize.large,
            status: EqWidgetStatus.primary,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormInputs() {
    return [
      EqSelect(
        label: "Type",
        hint: 'Choisi le type',
        shape: EqWidgetShape.semiRound,
        items: [
          EqSelectItem(title: 'Petit projet', value: 'petit-projet'),
          EqSelectItem(title: 'Grand grojet', value: 'grand-projet'),
          EqSelectItem(title: 'Adhoc', value: 'commission-regionale'),
        ],
        onSelect: (value) => {type = value},
      ),
      SizedBox(height: 16.0),
      EqSelect(
        label: "Critère de recherche",
        hint: 'Choisi la critère de recherche',
        shape: EqWidgetShape.semiRound,
        items: [
          EqSelectItem(
              title: "Date de la commission", value: 'date-de-la-commission'),
          EqSelectItem(title: "Architecte", value: 'architecte'),
          EqSelectItem(title: "Commune", value: 'commune'),
          EqSelectItem(title: "Numero de dossier", value: 'numero-de-dossier'),
        ],
        onSelect: (value) => setState(() => {critereDeRecherche = value}),
      ),
      SizedBox(height: 20.0),
      critereDeRecherche == "date-de-la-commission"
          ? GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: EqTextField(
                enabled: false,
                hint: DateFormat('dd/MM/yyyy').format(selectedDate).toString(),
                onChanged: (value) {
                  critereDeRechercheValue = value;
                },
                status: EqWidgetStatus.primary,
                icon: Icons.calendar_today,
                label: "Date de la commission",
                shape: EqWidgetShape.semiRound,
                iconPosition: EqPositioning.right,
              ),
            )
          : Container(),
      critereDeRecherche == "architecte"
          ? EqTextField(
              hint: "saisi le nom de l'architecte",
              onChanged: (value) {
                critereDeRechercheValue = value;
              },
              status: EqWidgetStatus.primary,
              icon: Icons.person,
              label: "Architecte",
              shape: EqWidgetShape.semiRound,
              iconPosition: EqPositioning.right,
            )
          : Container(),
      critereDeRecherche == "commune"
          ? EqTextField(
              hint: "saisi le nom de la commune",
              onChanged: (value) {
                critereDeRechercheValue = value;
              },
              status: EqWidgetStatus.primary,
              icon: Icons.home,
              label: "Nom de la commune",
              shape: EqWidgetShape.semiRound,
              iconPosition: EqPositioning.right,
            )
          : Container(),
      critereDeRecherche == "numero-de-dossier"
          ? EqTextField(
              hint: "saisi le numero de dossier",
              onChanged: (value) {
                critereDeRechercheValue = value;
              },
              status: EqWidgetStatus.primary,
              icon: Icons.title,
              label: "Numero de dossier",
              shape: EqWidgetShape.semiRound,
              iconPosition: EqPositioning.right,
            )
          : Container(),
      SizedBox(height: 16.0),
    ];
  }

  _rechercheButtonFunction() {
    if (critereDeRecherche == "" ||
        critereDeRechercheValue == "" ||
        type == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: EqCard(
                    footerPadding: EdgeInsets.all(1),
                    header: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.warning,
                              color: Colors.blueGrey,
                            ),
                            SizedBox(width: 22,),
                            EqText(
                              "Le formulaire est incomplet",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: MediaQuery.of(context).size.width < 400 ? 11 : 16,
                              ),
                            )
                          ],
                        ),
                        EqIconButton(
                          icon: Icons.close,
                          color: Colors.blueGrey,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: EqText(
                            (type == ""
                                    ? "Merci de choisir le type \n\n"
                                    : "") +
                                (critereDeRecherche == ""
                                    ? "Merci de choisir la critere de recherche \n\n"
                                    : "") +
                                (critereDeRechercheValue == ""
                                    ? "Merci de saisir la valuer de la critere de recherche"
                                    : ""),
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width < 400 ? 10 : 14,
                              color: Colors.blueGrey
                            ),
                          ),
                        ),
                        Container()
                      ],
                    ),
                    status: EqWidgetStatus.primary,
                    shape: EqWidgetShape.semiRound),
              ),
            );

          });
    } else {
      if (critereDeRecherche == "date-de-la-commission")
        critereDeRechercheValue =
            DateFormat('dd/MM/yyyy').format(selectedDate).toString();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultatsPage(
                    type: type,
                    critereDeRecherche: critereDeRecherche,
                    critereDeRechercheValue: critereDeRechercheValue,
                  )));
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2010, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        critereDeRechercheValue =
            DateFormat('dd/MM/yyyy').format(selectedDate).toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return EqLayout(
        child: Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          _buildBody()
        ],
      ),
    ));
  }
}
