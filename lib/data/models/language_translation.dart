class Translations {
  List<LanguageTranslation> translations;

  Translations({this.translations});

  Translations.fromJson(Map<String, dynamic> json) {
    if (json['translations'] != null) {
      translations = <LanguageTranslation>[];
      json['translations'].forEach((v) {
        translations.add(new LanguageTranslation.fromJson(v));
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

class LanguageTranslation {
  String value;

  LanguageTranslation({this.value});

  LanguageTranslation.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}
