/// UI libraries
import 'package:equinox/equinox.dart' hide Colors;

/// flutter libraries
import 'package:flutter/material.dart';

/// Models
import 'package:urbamoga/models/Bulletin.dart';

/// Widgets libraries
import 'package:html/parser.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:transparent_image/transparent_image.dart';

/// Functionality libraries
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

/// BulletinPage screen Widget
class BulletinPage extends StatelessWidget {
  final Bulletin bulletin;

  const BulletinPage({
    Key key,
    @required this.bulletin,
  }) : super(key: key);

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _share() {
    String bulletinTitleFormated = parse(parse(bulletin.title).body.text)
        .documentElement
        .text
        .replaceAll("\n", " ");

    String sharedLink = bulletin.url;

    String sharedMsg = bulletinTitleFormated + " \n\n " + sharedLink;

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
            SizedBox(height: 10),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Container(
                    child: Html(
                  data: bulletin.title,
                  useRichText: true,
                  defaultTextStyle: TextStyle(fontSize: 16),
                )),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    bulletin.date,
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
                      data: bulletin.content,
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
                SizedBox(height: 20),
                Container(
                  child: Center(
                    child: EqButton.outline(
                        size: EqWidgetSize.medium,
                        shape: EqWidgetShape.semiRound,
                        status: EqWidgetStatus.primary,
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.picture_as_pdf,
                              color: Color(0xff3366ff),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Telecharger le fichier attaché",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                          ? 8
                                          : 15),
                            ),
                          ],
                        ),
                        onTap: () {
                          _launchURL(bulletin.attachment);
                        }),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
