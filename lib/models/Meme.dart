class Meme {
  String url;
  List<String> likedUsers;

  Meme({required this.url, this.likedUsers = const []});

  Map<String, dynamic> toMap() {
    return {'url': url, 'likedUsers': likedUsers};
  }

  factory Meme.fromMap(Map<String, dynamic> map) {
    return Meme(url: map['url'], likedUsers: map['likedUsers']);
  }
}
