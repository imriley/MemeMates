import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mememates/models/MoodBoard.dart';
import 'package:mememates/models/Match.dart';

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
  String? profileMusicTitle;
  String? profileMusicThumbnailUrl;
  String? profileMusicArtist;
  List<String> likedUsers;
  List<Match> matches;

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
    this.profileMusicTitle,
    this.profileMusicThumbnailUrl,
    this.profileMusicArtist,
    this.likedUsers = const [],
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
      'profileMusicTitle': profileMusicTitle,
      "profileMusicThumbnailUrl": profileMusicThumbnailUrl,
      'profileMusicArtist': profileMusicArtist,
      'likedUsers': likedUsers,
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
      profileMusicTitle: map['profileMusicTitle'],
      profileMusicThumbnailUrl: map['profileMusicThumbnailUrl'],
      profileMusicArtist: map['profileMusicArtist'],
      likedUsers:
          map['likedUsers'] != null ? List<String>.from(map['likedUsers']) : [],
      matches: map['matches'] != null
          ? List<Match>.from((map['matches'] as List).map((match) {
              if (match is Map<String, dynamic>) {
                return Match.fromMap(match);
              } else {
                print("Invalid match data: $match");
                return null;
              }
            }).where((match) => match != null))
          : [],
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
    String? profileMusicTitle,
    String? profileMusicThumbnailUrl,
    String? profileMusicArtist,
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
      profileMusicTitle: profileMusicTitle ?? this.profileMusicTitle,
      profileMusicThumbnailUrl:
          profileMusicThumbnailUrl ?? this.profileMusicThumbnailUrl,
      profileMusicArtist: profileMusicArtist ?? this.profileMusicArtist,
      matches: matches,
    );
  }

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, name: $name, isEmailVerified: $isEmailVerified, dateOfBirth: $dateOfBirth, age: $age, gender: $gender, preferenceGender: $preferenceGender, preferenceAgeMin: $preferenceAgeMin, preferenceAgeMax: $preferenceAgeMax, interests: $interests, profileImageUrl: $profileImageUrl, moodBoard: $moodBoard, profileMusicTitle: $profileMusicTitle, profileMusicThumbnailUrl: $profileMusicThumbnailUrl, profileMusicArtist: $profileMusicArtist, likedUsers: $likedUsers, matches: $matches}';
  }
}
