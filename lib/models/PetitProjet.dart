class PetitProjet {
  String postType;
  String type;
  String dateDeLaCommission;
  String avisDeLaCommission;
  String architecte;
  String situationDuProjet;
  String commune;
  String natureDuProjet;
  String proprietaire;
  String numeroDeDossier;

  PetitProjet(
      {this.postType,
      this.type,
      this.dateDeLaCommission,
      this.avisDeLaCommission,
      this.architecte,
      this.situationDuProjet,
      this.commune,
      this.natureDuProjet,
      this.proprietaire,
      this.numeroDeDossier});

  PetitProjet.fromJson(Map<String, dynamic> json) {
    postType = json['post_type'];
    type = json['wpcf-type'];
    dateDeLaCommission = json['wpcf-date-de-la-commission'];
    avisDeLaCommission = json['wpcf-avis-de-la-commission'];
    architecte = json['wpcf-architecte'];
    situationDuProjet = json['wpcf-situation-du-projet'];
    commune = json['wpcf-commune'];
    natureDuProjet = json['wpcf-nature-du-projet'];
    proprietaire = json['wpcf-proprietaire'];
    numeroDeDossier = json['wpcf-numero-de-dossier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_type'] = this.postType;
    data['wpcf-type'] = this.type;
    data['wpcf-date-de-la-commission'] = this.dateDeLaCommission;
    data['wpcf-avis-de-la-commission'] = this.avisDeLaCommission;
    data['wpcf-architecte'] = this.architecte;
    data['wpcf-situation-du-projet'] = this.situationDuProjet;
    data['wpcf-commune'] = this.commune;
    data['wpcf-nature-du-projet'] = this.natureDuProjet;
    data['wpcf-proprietaire'] = this.proprietaire;
    data['wpcf-numero-de-dossier'] = this.numeroDeDossier;
    return data;
  }

  @override
  String toString() {
    return dateDeLaCommission == null ? " " : dateDeLaCommission;
  }
}
