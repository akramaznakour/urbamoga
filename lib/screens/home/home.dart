/// UI libraries
import 'package:equinox/equinox.dart' hide Colors;

/// flutter libraries
import 'package:flutter/material.dart';

/// Functionality libraries
import 'package:url_launcher/url_launcher.dart';

/// Screens
import 'package:urbamoga/screens/actualites/actualites.dart';
import 'package:urbamoga/screens/bulletins/bulletins.dart';
import 'package:urbamoga/screens/cart/cart.dart';
import 'package:urbamoga/screens/publications/publications.dart';
import 'package:urbamoga/screens/resultats_commissions/resultats_commissions.dart';
import 'package:urbamoga/screens/statistiques/statistiques.dart';

/// Home screen widget
class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

/// Home Widget State
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final String _appTitile = 'Agence Urbaine Essaouira';
  TabController _tabController;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  void _animateToTab(_tabIndex) {
    _tabController.animateTo(_tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return EqLayout(
        appBar: EqAppBar(
          centerTitle: false,
          actions: _buildActionsBar(context),
          leading: MediaQuery.of(context).size.width > 400
              ? SizedBox(
                  width: 0,
                  height: 0,
                )
              : IconButton(
                  color: Colors.blueGrey,
                  icon: Icon(Icons.info),
                  onPressed: () {
                    _buildAboutDialog(context);
                  }),
          title: _appTitile,
          bottom: EqTabs(
            onSelect: _animateToTab,
            tabs: _buildBarTabs(context),
          ),
        ),
        child: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Actualites(),
              Bulletins(),
              Publications(),
              Statistiques(),
              ResultatsCommissions(),
            ]));
  }

  List<Widget> _buildActionsBar(context) => [
        IconButton(
            color: Colors.blueGrey,
            icon: Icon(Icons.location_on),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            }),
        MediaQuery.of(context).size.width < 400
            ? SizedBox(
                width: 0,
                height: 0,
              )
            : IconButton(
                color: Colors.blueGrey,
                icon: Icon(Icons.info),
                onPressed: () {
                  _buildAboutDialog(context);
                })
      ];

  _buildAboutDialog(BuildContext context) {
    // return object of type Dialog

    showDialog(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height - 300,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
            child: EqCard(
          footerPadding: EdgeInsets.all(10),
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EqText(
                    "URBAMOGA",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MediaQuery.of(context).size.height < 400 ? Container():Image.asset(
                "assets/logo.png",
                width: 120,
                height: 120,
              ),
              EqText(
                "Copyright 2019 ©  Agence Urbaine d’Essaouira",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  EqText(
                      "123 Lotissement Almoustaqbal \n  BP 409 Essaouira Principal",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width < 400 ? 8 : 12),
                      eqStyle: EqTextStyle.caption2)
                ],
              ),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  EqText("Standard: 05 24 47 40 37",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width < 400 ? 8 : 12),
                      eqStyle: EqTextStyle.caption2)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  EqText("Fax: 05 24 47 40 38 ",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width < 400 ? 8 : 12),
                      eqStyle: EqTextStyle.caption2)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  EqButton.ghost(
                    label: EqText("https://auessaouira.ma/",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 400
                                ? 8
                                : 12),
                        status: EqWidgetStatus.primary,
                        eqStyle: EqTextStyle.caption2),
                    onTap: () {
                      _launchURL("https://auessaouira.ma/");
                    },
                  )
                ],
              )
            ],
          ),
          status: EqWidgetStatus.primary,
          shape: EqWidgetShape.semiRound,
        )),
      ),
    );
  }

  List<EqTabData> _buildBarTabs(context) {
    List<EqTabData> tabas = List<EqTabData>();

    [
      {'icon': Icons.chat, 'title': 'Actualités'},
      {'icon': Icons.receipt, 'title': 'Bulletins'},
      {'icon': Icons.library_books, 'title': 'Publications'},
      {'icon': Icons.insert_chart, 'title': 'Statistiques'},
      {'icon': Icons.search, 'title': 'resultats'},
    ].forEach((tab) => {
          tabas.add(EqTabData(
              title: (_) => Text(
                    tab['title'],
                    style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width < 400 ? 9 : 12),
                  ),
              icon: (_) => Icon(
                    tab['icon'],
                    color: Colors.blueGrey,
                  )))
        });

    return tabas;
  }
}
