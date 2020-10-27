/// UI libraries
import 'package:equinox/equinox.dart' hide Colors;

/// flutter libraries
import 'package:flutter/material.dart';

/// Models
import 'package:urbamoga/models/Actualite.dart';

/// Widgets libraries
import 'package:html/parser.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:transparent_image/transparent_image.dart';

/// Functionality libraries
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

/// ActualitePage screen Widget
class ActualitePage extends StatelessWidget {
  final Actualite actualite;

  const ActualitePage({
    Key key,
    @required this.actualite,
  }) : super(key: key);

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _share() {
    String actualiteTitleFormated = parse(parse(actualite.title).body.text)
        .documentElement
        .text
        .replaceAll("\n", " ");

    String sharedLink = actualite.url;

    String sharedMsg = actualiteTitleFormated + " \n\n " + sharedLink;

    Share.share(sharedMsg);
  }

  @override
  Widget build(BuildContext context) {
    return EqLayout(
        appBar: EqAppBar(
          title: "",
          actions: <Widget>[
            EqIconButton(
              icon: EvaIcons.share,
              onTap: () {
                _share();
              },
            )
          ],
        ),
        child: ListView(
          children: <Widget>[
            actualite.image == "" ? Container() : SizedBox(height: 10),
            actualite.image == ""
                ? Container()
                : Container(
              padding: EdgeInsets.only(left: 20),
              height: 250,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: actualite.image,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: actualite.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Container(
                    child: Html(
                      data: actualite.title,
                      useRichText: true,
                      defaultTextStyle: TextStyle(fontSize: 16),
                    )),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    actualite.date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.blueGrey[300],
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Html(
                      data: actualite.content,
                      useRichText: true,
                      customTextAlign: (_) => TextAlign.justify,
                      defaultTextStyle: TextStyle(fontSize: 14),
                      onLinkTap: (url) {
                        _launchURL(url);
                      },
                      linkStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue),
                      padding: EdgeInsets.symmetric(vertical: 5),
                    )),
                SizedBox(height: 10),

              ],
            ),
          ],
        ));
  }
}
