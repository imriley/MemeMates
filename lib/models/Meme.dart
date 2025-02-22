class Meme {
  String url;
  List<String> femaleLikedUsers;
  List<String> maleLikedUsers;

  Meme({
    required this.url,
    this.femaleLikedUsers = const [],
    this.maleLikedUsers = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'femaleLikedUsers': femaleLikedUsers,
      'maleLikedUsers': maleLikedUsers
    };
  }

  factory Meme.fromMap(Map<String, dynamic> map) {
    List<dynamic> femaleDynamicList = map['femaleLikedUsers'] ?? [];
    List<String> femaleStringList =
        femaleDynamicList.map((item) => item.toString()).toList();
    List<dynamic> maleDynamicList = map['maleLikedUsers'] ?? [];
    List<String> maleStringList =
        maleDynamicList.map((item) => item.toString()).toList();

    return Meme(
      url: map['url'],
      femaleLikedUsers: femaleStringList,
      maleLikedUsers: maleStringList,
    );
  }
}
