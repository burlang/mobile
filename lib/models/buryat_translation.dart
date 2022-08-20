class Translations {
  List<BuryatTranslation> translations;

  Translations({this.translations});

  Translations.fromJson(Map<String, dynamic> json) {
    if (json['translations'] != null) {
      translations = <BuryatTranslation>[];
      json['translations'].forEach((v) {
        translations.add(new BuryatTranslation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.translations != null) {
      data['translations'] = this.translations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BuryatTranslation {
  String value;

  BuryatTranslation({this.value});

  BuryatTranslation.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}
