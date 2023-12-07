import 'dart:convert';

List<Kalender> kalenderFromJson(String str) =>
    List<Kalender>.from(json.decode(str).map((x) => Kalender.fromJson(x)));

String kalenderToJson(List<Kalender> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kalender {
  final String title;
  final String note;
  final DateTime date;

  Kalender(this.title, this.note, this.date);

  factory Kalender.fromMap(Map<String, dynamic> map) {
    return Kalender(
      map['title'],
      map['note'],
      DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'note': note,
      'date': date.toIso8601String(),
    };
  }

  factory Kalender.fromJson(Map<String, dynamic> json) {
    return Kalender(
      json['title'],
      json['note'],
      DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'date': date.toIso8601String(),
    };
  }
}
