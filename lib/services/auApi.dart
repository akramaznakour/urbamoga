/// libraries
import 'dart:async';
import 'dart:convert' show json, utf8;
import 'package:http/http.dart' as http;

/// Models
import 'package:urbamoga/models/Actualite.dart';
import 'package:urbamoga/models/Bulletin.dart';
import 'package:urbamoga/models/Publication.dart';
import 'package:urbamoga/models/Canvas.dart';
import 'package:urbamoga/models/Projet.dart';

/// constants APi apiBaseUrl
const apiBaseUrl = "https://auessaouira.ma/wp-json/api/v1/";

/// fetch actualites
Future<List<Actualite>> getActualites() async {
  http.Response response = await http.get(apiBaseUrl + "actualites");

  var actualitesData = json.decode(response.body);

  List<Actualite> actualites = [];

  for (var actualiteData in actualitesData)
    actualites.add(Actualite.fromJson(actualiteData));

  return actualites;
}

/// fetch bulletins
Future<List<Bulletin>> getBulletins() async {
  http.Response response = await http.get(apiBaseUrl + "bulletins");

  var bulletinsData = json.decode(response.body);

  List<Bulletin> bulletins = [];

  for (var bulletinData in bulletinsData)
    bulletins.add(Bulletin.fromJson(bulletinData));

  return bulletins;
}

/// fetch publications
Future<List<Publication>> getPublications() async {
  http.Response response = await http.get(apiBaseUrl + "publications");

  var publicationsData = json.decode(response.body);

  List<Publication> publications = [];

  for (var publicationData in publicationsData)
    publications.add(Publication.fromJson(publicationData));

  return publications;
}

/// fetch statistiques
Future<List<Canvas>> getStatistiques() async {
  http.Response response = await http.get(apiBaseUrl + "statistiques");

  var canvasesData = json.decode(response.body);

  List<Canvas> canvses = [];

  for (var canvasData in canvasesData) canvses.add(Canvas.fromJson(canvasData));

  return canvses;
}

/// fetch search results
Future<List<Projet>> searchResultatsCommissions({
  String type,
  String critereDeRecherche,
  String critereDeRechercheValue,
}) async {
  String args = "";
  args += "?type=";
  args += type != null ? type : "";
  args += "&critereDeRecherche=";
  args += critereDeRecherche != null ? critereDeRecherche : "";
  args += "&critereDeRechercheValue=";
  args += critereDeRechercheValue != null ? critereDeRechercheValue : "";

  print(apiBaseUrl + "resultatsCommissions" + args);

  http.Response response =
      await http.get(apiBaseUrl + "resultatsCommissions" + args);

  var projetsData = json.decode(utf8.decode(response.bodyBytes));

  List<Projet> projets = [];

  for (var projetData in projetsData) projets.add(Projet.fromJson(projetData));

  return projets;
}
