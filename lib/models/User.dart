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
  String? pronouns;
  String? work;
  String? college;
  String? hometown;
  String? datingGoals;
  String? religiousBeliefs;
  String? height;
  String? drinking;
  String? smoking;
  String? profileImageUrl;
  MoodBoard? moodBoard;
  String? profileMusicTitle;
  String? profileMusicThumbnailUrl;
  String? profileMusicArtist;
  List<String> likedUsers;
  List<String> skippedUsers;
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
    this.pronouns,
    this.work,
    this.college,
    this.hometown,
    this.datingGoals,
    this.religiousBeliefs,
    this.height,
    this.drinking,
    this.smoking,
    this.profileImageUrl,
    this.moodBoard,
    this.profileMusicTitle,
    this.profileMusicThumbnailUrl,
    this.profileMusicArtist,
    this.likedUsers = const [],
    this.skippedUsers = const [],
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
      'pronouns': pronouns,
      'work': work,
      'college': college,
      'hometown': hometown,
      'datingGoals': datingGoals,
      'religiousBeliefs': religiousBeliefs,
      'height': height,
      'drinking': drinking,
      'smoking': smoking,
      'profileImageUrl': profileImageUrl,
      'moodBoard': moodBoard?.toMap(),
      'profileMusicTitle': profileMusicTitle,
      "profileMusicThumbnailUrl": profileMusicThumbnailUrl,
      'profileMusicArtist': profileMusicArtist,
      'likedUsers': likedUsers,
      'skippedUsers': skippedUsers,
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
      pronouns: map['pronouns'],
      work: map['work'],
      college: map['college'],
      hometown: map['hometown'],
      datingGoals: map['datingGoals'],
      religiousBeliefs: map['religiousBeliefs'],
      height: map['height'],
      drinking: map['drinking'],
      smoking: map['smoking'],
      profileImageUrl: map['profileImageUrl'],
      moodBoard:
          map['moodBoard'] != null ? MoodBoard.fromMap(map['moodBoard']) : null,
      profileMusicTitle: map['profileMusicTitle'],
      profileMusicThumbnailUrl: map['profileMusicThumbnailUrl'],
      profileMusicArtist: map['profileMusicArtist'],
      likedUsers:
          map['likedUsers'] != null ? List<String>.from(map['likedUsers']) : [],
      skippedUsers: map['skippedUsers'] != null
          ? List<String>.from(map['skippedUsers'])
          : [],
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
    String? pronouns,
    String? work,
    String? college,
    String? hometown,
    String? datingGoals,
    String? religiousBeliefs,
    String? height,
    String? drinking,
    String? smoking,
    String? profileImageUrl,
    MoodBoard? moodBoard,
    String? profileMusicTitle,
    String? profileMusicThumbnailUrl,
    String? profileMusicArtist,
    List<String>? likedUsers,
    List<String>? skippedUsers,
    List<Match>? matches,
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
      pronouns: pronouns ?? this.pronouns,
      work: work ?? this.work,
      college: college ?? this.college,
      hometown: hometown ?? this.hometown,
      datingGoals: datingGoals ?? this.datingGoals,
      religiousBeliefs: religiousBeliefs ?? this.religiousBeliefs,
      height: height ?? this.height,
      drinking: drinking ?? this.drinking,
      smoking: smoking ?? this.smoking,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      moodBoard: moodBoard ?? this.moodBoard,
      profileMusicTitle: profileMusicTitle ?? this.profileMusicTitle,
      profileMusicThumbnailUrl:
          profileMusicThumbnailUrl ?? this.profileMusicThumbnailUrl,
      profileMusicArtist: profileMusicArtist ?? this.profileMusicArtist,
      likedUsers: likedUsers ?? this.likedUsers,
      skippedUsers: skippedUsers ?? this.skippedUsers,
      matches: matches ?? this.matches,
    );
  }

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, name: $name, isEmailVerified: $isEmailVerified, dateOfBirth: $dateOfBirth, age: $age, gender: $gender, preferenceGender: $preferenceGender, preferenceAgeMin: $preferenceAgeMin, preferenceAgeMax: $preferenceAgeMax, interests: $interests, pronouns: $pronouns, work: $work, college: $college, hometown: $hometown, datingGoals: $datingGoals, religiousBeliefs: $religiousBeliefs, height: $height, drinking: $drinking, smoking: $smoking, profileImageUrl: $profileImageUrl, moodBoard: $moodBoard, profileMusicTitle: $profileMusicTitle, profileMusicThumbnailUrl: $profileMusicThumbnailUrl, profileMusicArtist: $profileMusicArtist, likedUsers: $likedUsers, skippedUsers: $skippedUsers, matches: $matches}';
  }
}
