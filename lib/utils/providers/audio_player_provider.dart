import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final YoutubeExplode _youtube = YoutubeExplode();

  AudioPlayer get player => _audioPlayer;

  Future<String> fetchYoutubeUrl(String title) async {
    try {
      final result =
          await _youtube.search.search(title, filter: TypeFilters.video);
      final videoId = result.first.id.value;
      final manifest = await _youtube.videos.streamsClient.getManifest(videoId);
      final audioUrl = manifest.audioOnly.first.url;
      return audioUrl.toString();
    } catch (e) {
      return null.toString();
    }
  }
}
