import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mememates/models/MoodBoard.dart';

class User {
  String? uid;
  String? email;
  String? name;
  bool? isEmailVerified;
  DateTime? dateOfBirth;
  int? age;
  String? gender;
  String? preferenceGender;
  int? preferenceAgeMin;
  int? preferenceAgeMax;
  List<String> interests;
  String? profileImageUrl;
  MoodBoard? moodBoard;
  String? profileAnthem;
  List<String> matches;

  User({
    this.uid,
    this.email,
    this.name,
    this.isEmailVerified,
    this.dateOfBirth,
    this.age,
    this.gender,
    this.preferenceGender,
    this.preferenceAgeMin,
    this.preferenceAgeMax,
    this.interests = const [],
    this.profileImageUrl,
    this.moodBoard,
    this.profileAnthem,
    this.matches = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'isEmailVerified': isEmailVerified,
      'dateOfBirth': dateOfBirth,
      'age': age,
      'gender': gender,
      'preferenceGender': preferenceGender,
      'preferenceAgeMin': preferenceAgeMin,
      'preferenceAgeMax': preferenceAgeMax,
      'interests': interests,
      'profileImageUrl': profileImageUrl,
      'moodBoard': moodBoard?.toMap(),
      'profileAnthem': profileAnthem,
      'matches': matches,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      isEmailVerified: map['isEmailVerified'],
      dateOfBirth: map['dateOfBirth'] != null
          ? (map['dateOfBirth'] as Timestamp).toDate()
          : null,
      age: map['age'],
      gender: map['gender'],
      preferenceGender: map['preferenceGender'],
      preferenceAgeMin: map['preferenceAgeMin'],
      preferenceAgeMax: map['preferenceAgeMax'],
      interests: List<String>.from(map['interests']),
      profileImageUrl: map['profileImageUrl'],
      moodBoard:
          map['moodBoard'] != null ? MoodBoard.fromMap(map['moodBoard']) : null,
      profileAnthem: map['profileAnthem'],
      matches: List<String>.from(map['matches']),
    );
  }

  User copyWith({
    String? uid,
    String? email,
    String? name,
    bool? isEmailVerified,
    DateTime? dateOfBirth,
    int? age,
    String? gender,
    String? preferenceGender,
    int? preferenceAgeMin,
    int? preferenceAgeMax,
    List<String>? interests,
    String? profileImageUrl,
    MoodBoard? moodBoard,
    String? profileAnthem,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      preferenceGender: preferenceGender ?? this.preferenceGender,
      preferenceAgeMin: preferenceAgeMin ?? this.preferenceAgeMin,
      preferenceAgeMax: preferenceAgeMax ?? this.preferenceAgeMax,
      interests: interests ?? this.interests,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      moodBoard: moodBoard ?? this.moodBoard,
      profileAnthem: profileAnthem ?? this.profileAnthem,
      matches: matches,
    );
  }

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, name: $name, isEmailVerified: $isEmailVerified, dateOfBirth: $dateOfBirth, age: $age, gender: $gender, preferenceGender: $preferenceGender, preferenceAgeMin: $preferenceAgeMin, preferenceAgeMax: $preferenceAgeMax, interests: $interests, profileImageUrl: $profileImageUrl, moodBoard: $moodBoard, profileAnthem: $profileAnthem, matches: $matches}';
  }
}
