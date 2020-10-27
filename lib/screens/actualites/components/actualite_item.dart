/// UI libraries
import 'package:equinox/equinox.dart' hide Colors;

/// flutter libraries
import 'package:flutter/material.dart';

/// Models
import 'package:urbamoga/models/Actualite.dart';

/// Screens
import 'package:urbamoga/screens/actualites/components/actualite_page.dart';

/// Widgets libraries
import 'package:html/parser.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:transparent_image/transparent_image.dart';

/// ActualiteItem component widget
class ActualiteItem extends StatelessWidget {
  final Actualite actualite;

  const ActualiteItem({
    Key key,
    @required this.actualite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ActualitePage(
                    actualite: actualite,
                  )),
        ),
        child: EqCard(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height /
                        (actualite.image == "" ? 20 : 4),
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: actualite.image == ""
                          ? Container()
                          : Hero(
                              tag: actualite.image,
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: actualite.image,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    right: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          " ${actualite.date} ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Html(data: actualite.title)),
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    parse(parse(actualite.content).body.text)
                                .documentElement
                                .text
                                .replaceAll("\n", " ")
                                .length >
                            170
                        ? parse(parse(actualite.content).body.text)
                                .documentElement
                                .text
                                .replaceAll("\n", " ")
                                .substring(0, 170) +
                            "..."
                        : parse(parse(actualite.content).body.text)
                            .documentElement
                            .text
                            .replaceAll("\n", " "),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
