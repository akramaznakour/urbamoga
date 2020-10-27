/// UI libraries
import 'package:equinox/equinox.dart' hide Colors;

/// flutter libraries
import 'package:flutter/material.dart';

/// Widgets libraries
import 'package:html/parser.dart';
import 'package:flutter_html/flutter_html.dart';

/// Functionality libraries
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

/// Widgets libraries
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

/// Api services
import 'package:urbamoga/services/auApi.dart';

/// Publications screen Widget
class Publications extends StatelessWidget {
  const Publications({
    Key key,
  }) : super(key: key);

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _share(publication) {
    String publicationTitleFormated = parse(parse(publication.title).body.text)
        .documentElement
        .text
        .replaceAll("\n", " ");

    String sharedLink = publication.url;

    String sharedMsg = publicationTitleFormated + " \n\n " + sharedLink;

    Share.share(sharedMsg);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 170,
            child: _buildPublicationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPublicationsList() => FutureBuilder(
      future: getPublications(),
      builder: (BuildContext context, AsyncSnapshot publicationsSnap) {
        if (publicationsSnap.data == null) {
          if (publicationsSnap.connectionState == ConnectionState.done) {
            return _buildConnectionError();
          } else {
            return _buildLoading();
          }
        } else {
          return Container(
            child: ListView.builder(
                itemCount: publicationsSnap.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: EqCard(
                      statusAppearance: EqCardStatusAppearance.header,
                      shape: EqWidgetShape.semiRound,
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              child: Html(
                                data: publicationsSnap.data[index].title,
                              ),
                              width: MediaQuery.of(context).size.width / 1.4),
                          Container(
                            child: EqIconButton(
                              icon: Icons.share,
                              onTap: () {
                                _share(publicationsSnap.data[index]);
                              },
                            ),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Html(
                          data: publicationsSnap.data[index].content,
                          useRichText: true,
                          defaultTextStyle: TextStyle(fontSize: 12),
                          linkStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                          onLinkTap: (url) => _launchURL(url),
                        ),
                      ),
                    ),
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
            "aucune publication n'a été trouvée. \n\n verifier votre connexion internet et réessayer",
            textAlign: TextAlign.center,
          ),
        ),
      );
}
