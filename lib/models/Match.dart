class Match {
  String userId;
  bool hasLiked;
  bool hasSentMeme;

  Match({
    required this.userId,
    required this.hasLiked,
    required this.hasSentMeme,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'hasLiked': hasLiked,
      'hasSentMeme': hasSentMeme,
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      userId: map['userId'] ?? '',
      hasLiked: map['hasLiked'] ?? false,
      hasSentMeme: map['hasSentMeme'] ?? false,
    );
  }
}
