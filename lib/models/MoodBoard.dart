class MoodBoard {
  List<String> images;

  MoodBoard({required this.images});

  Map<String, dynamic> toMap() {
    return {
      'images': images,
    };
  }

  factory MoodBoard.fromMap(Map<String, dynamic> map) {
    return MoodBoard(
      images: List<String>.from(map['images']),
    );
  }
}
