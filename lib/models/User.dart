import 'package:mememates/models/MoodBoard.dart';

class User {
  String? uid; // Unique user ID
  String? name;
  DateTime? dateOfBirth;
  int? age;
  String? gender;
  String? preferenceGender; // e.g., "Male", "Female", "All"
  int? preferenceAgeMin;
  int? preferenceAgeMax;
  String? profileImageUrl; // Optional
  MoodBoard? moodBoard;
  String? profileAnthem; // Song ID or URL
  List<String> matches; // List of user IDs

  User({
    this.uid,
    this.name,
    this.dateOfBirth,
    this.age,
    this.gender,
    this.preferenceGender,
    this.preferenceAgeMin,
    this.preferenceAgeMax,
    this.profileImageUrl,
    this.moodBoard,
    this.profileAnthem,
    this.matches = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'age': age,
      'gender': gender,
      'preferenceGender': preferenceGender,
      'preferenceAgeMin': preferenceAgeMin,
      'preferenceAgeMax': preferenceAgeMax,
      'profileImageUrl': profileImageUrl,
      'moodBoard': moodBoard?.toMap(),
      'profileAnthem': profileAnthem,
      'matches': matches,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      name: map['name'],
      dateOfBirth: map['dateOfBirth'],
      age: map['age'],
      gender: map['gender'],
      preferenceGender: map['preferenceGender'],
      preferenceAgeMin: map['preferenceAgeMin'],
      preferenceAgeMax: map['preferenceAgeMax'],
      profileImageUrl: map['profileImageUrl'],
      moodBoard:
          map['moodBoard'] != null ? MoodBoard.fromMap(map['moodBoard']) : null,
      profileAnthem: map['profileAnthem'],
      matches: List<String>.from(map['matches']),
    );
  }
}
