class BuryatName {
  final String name;
  final String description;
  final String note;
  final int male;
  final int female;

  BuryatName({
   this.name,
     this.description,
     this.note,
     this.male, 
     this.female
  });

  factory BuryatName.fromJson(Map<String, dynamic> json) {
    return BuryatName(
      name: json['name'],
      description: json['description'],
      note: json['note'],
      male: json['male'],
      female: json['female']
    );
  }
}
