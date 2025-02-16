import 'package:audioplayers/audioplayers.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mememates/screens/profile_setup/finalize_profile_screen.dart';
import 'package:mememates/utils/misc/debouncer.dart';
import 'package:mememates/utils/providers/audio_player_provider.dart';
import 'package:mememates/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as sp;

class MusicSelectionScreen extends StatefulWidget {
  const MusicSelectionScreen({super.key});

  @override
  State<MusicSelectionScreen> createState() => _MusicSelectionScreenState();
}

class _MusicSelectionScreenState extends State<MusicSelectionScreen> {
  late sp.SpotifyApi spotify;
  List<sp.Track> tracks = [];
  late AudioPlayerProvider audioPlayerProvider;
  TextEditingController searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);
  String currentlyPlaying = "";
  String isProcessing = "";
  String selectedSongImage = '';
  String selectedSongTitle = '';
  String selectedSongArtist = '';
  bool submitProcessing = false;

  void removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context, listen: false);
    _initializeSpotify();
  }

  Future<void> _initializeSpotify() async {
    await dotenv.load();
    final credentials = sp.SpotifyApiCredentials(
      dotenv.env['SPOTIFY_CLIENT_ID'],
      dotenv.env['SPOTIFY_CLIENT_SECRET'],
    );
    spotify = sp.SpotifyApi(credentials);
  }

  Future<void> searchTracks(String query) async {
    try {
      List searchResults = await spotify.search
          .get(query, types: [sp.SearchType.track], market: sp.Market.US)
          .first(10);
      for (var page in searchResults) {
        setState(() {
          tracks = [...page.items];
        });
      }
    } catch (e) {
      setState(() {
        tracks = [];
      });
      print("Error searching tracks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: removeFocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              IconsaxOutline.arrow_left_2,
            ),
          ),
        ),
        bottomSheet: Container(
          margin: EdgeInsets.only(
            bottom: 32,
          ),
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: TextButton(
            onPressed: () async {
              if (submitProcessing) return;
              if (selectedSongTitle.isNotEmpty) {
                setState(() {
                  submitProcessing = true;
                });
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user!.copyWith(
                  profileMusicTitle: selectedSongTitle,
                  profileMusicThumbnailUrl: selectedSongImage,
                  profileMusicArtist: selectedSongArtist,
                ));
                await audioPlayerProvider.player.stop();
                Navigator.push(
                  context,
                  cupertino.CupertinoPageRoute(
                    builder: (context) => FinalizeProfileScreen(),
                  ),
                );
                setState(() {
                  submitProcessing = false;
                });
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFFE94158),
              padding: EdgeInsets.all(
                16,
              ),
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
            child: submitProcessing
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                LinearProgressIndicator(
                  value: 99 / 100,
                  color: Color(0xFFe94158),
                  backgroundColor: Color(0xFFE3E5E5),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "Let's select your profile anthem",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                selectedSongTitle.isEmpty
                    ? cupertino.CupertinoTextField(
                        autofocus: true,
                        controller: searchController,
                        placeholder: "Search for a song...",
                        placeholderStyle: TextStyle(
                          color: Color(0xFF6D7171),
                        ),
                        padding: EdgeInsets.all(
                          16,
                        ),
                        style: TextStyle(
                          color: Color(0xFF090A0A),
                          fontSize: 18,
                          letterSpacing: 0.4,
                        ),
                        onChanged: (value) async {
                          _debouncer.run(() async {
                            await searchTracks(value);
                          });
                        },
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(
                              0xFFE3E5E5,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      )
                    : ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          side: BorderSide(
                            color: Color(0xFFE3E5E5),
                          ),
                        ),
                        leading: Image.network(selectedSongImage),
                        title: Text(
                          selectedSongTitle,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          selectedSongArtist,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7D7D7D),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              selectedSongTitle = "";
                              selectedSongImage = "";
                              selectedSongArtist = "";
                            });
                          },
                          icon: Icon(AntDesign.close_outline, size: 20),
                        ),
                      ),
                SizedBox(
                  height: 8,
                ),
                tracks.isEmpty
                    ? Container()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: tracks.length,
                          itemBuilder: (context, index) {
                            final track = tracks[index];
                            return ListTile(
                              onTap: () async {
                                setState(() {
                                  tracks = [];
                                  selectedSongArtist = track.artists!.isNotEmpty
                                      ? track.artists!
                                          .take(2)
                                          .map((artist) => artist.name)
                                          .join(', ')
                                      : 'Unknown';
                                  selectedSongTitle = track.name.toString();
                                  selectedSongImage =
                                      track.album!.images![0].url!;
                                });
                              },
                              leading:
                                  Image.network(track.album!.images![0].url!),
                              title: Text(
                                track.name ?? "Nope",
                              ),
                              subtitle: Text(
                                track.artists!.isNotEmpty
                                    ? track.artists!
                                        .take(2)
                                        .map((artist) => artist.name)
                                        .join(', ')
                                    : "Nope",
                                style: TextStyle(
                                  color: Color(0xFF7D7D7D),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  if (isProcessing == track.id!) return;
                                  setState(() {
                                    isProcessing = track.id!;
                                  });
                                  if (currentlyPlaying == track.id!) {
                                    await audioPlayerProvider.player.pause();
                                    setState(() {
                                      currentlyPlaying = "";
                                    });
                                  } else {
                                    setState(() {
                                      currentlyPlaying = '';
                                    });
                                    final audioUrl = await audioPlayerProvider
                                        .fetchYoutubeUrl(
                                      track.name.toString(),
                                    );
                                    if (audioUrl == null.toString()) {
                                      return;
                                    }
                                    await audioPlayerProvider.player.setSource(
                                      UrlSource(audioUrl.toString()),
                                    );
                                    await audioPlayerProvider.player.resume();
                                    setState(() {
                                      currentlyPlaying = track.id!;
                                    });
                                  }
                                  setState(() {
                                    isProcessing = "";
                                  });
                                },
                                iconSize: 20,
                                icon: isProcessing == track.id!
                                    ? cupertino.CupertinoActivityIndicator()
                                    : currentlyPlaying == track.id
                                        ? Icon(IconsaxOutline.pause)
                                        : Icon(IconsaxOutline.play),
                              ),
                              contentPadding: EdgeInsets.zero,
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
