import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mememates/models/User.dart';
import 'package:mememates/utils/providers/audio_player_provider.dart';
import 'package:provider/provider.dart';

class ProfileDetailScreen extends StatefulWidget {
  User user;
  ProfileDetailScreen({
    super.key,
    required this.user,
  });

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  late AudioPlayerProvider audioPlayerProvider;
  bool canPop = false;
  PlayerState? _playerState;
  bool isLoading = true;

  @override
  void initState() {
    audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context, listen: false);
    playAnthem();
    _playerState = audioPlayerProvider.player.state;
    super.initState();
  }

  Future<void> playAnthem() async {
    if (widget.user.profileMusicTitle!.isNotEmpty) {
      final audioUrl = await audioPlayerProvider.fetchYoutubeUrl(
        widget.user.profileMusicTitle!,
      );
      if (audioUrl == null.toString()) return;
      if (mounted) {
        try {
          await audioPlayerProvider.player.setSource(UrlSource(audioUrl));
          await audioPlayerProvider.player.resume();
          setState(() {
            isLoading = false;
            _playerState = audioPlayerProvider.player.state;
          });
        } catch (e) {
          log("Something went wrong: $e");
        }
      }
    }
  }

  Future<void> stopAnthem() async {
    await audioPlayerProvider.player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          stopAnthem();
          return;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        widget.user.profileImageUrl!,
                        width: double.infinity,
                        height: 450,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildActionButton(
                              icon: AntDesign.close_outline,
                              backgroundColor: Colors.white,
                              iconColor: Colors.orange,
                              onTap: () async {
                                // await widget.onDislike();
                                Navigator.pop(context, true);
                              },
                            ),
                            _buildActionButton(
                              icon: IconsaxBold.heart,
                              backgroundColor: const Color(0xFFE94057),
                              iconColor: Colors.white,
                              size: 64,
                              onTap: () async {
                                // await widget.onLike();
                                // Navigator.of(context).pop();
                              },
                            ),
                            _buildActionButton(
                              icon: Icons.star,
                              backgroundColor: Colors.white,
                              iconColor: Colors.purple,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Profile Info Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.user.name}, ${widget.user.age}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                IconsaxOutline.send_2,
                                color: Color(0xFFE94057),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ListTile(
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
                          leading: Image.network(
                              widget.user.profileMusicThumbnailUrl!),
                          title: Text(
                            widget.user.profileMusicTitle!,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            widget.user.profileMusicArtist!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF7D7D7D),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              if (_playerState == PlayerState.paused) {
                                await audioPlayerProvider.player.resume();
                                setState(() {
                                  _playerState = PlayerState.playing;
                                });
                              } else if (_playerState == PlayerState.playing) {
                                await audioPlayerProvider.player.pause();
                                setState(() {
                                  _playerState = PlayerState.paused;
                                });
                              } else if (_playerState == PlayerState.stopped) {
                                await audioPlayerProvider.player.resume();
                                setState(() {
                                  _playerState = PlayerState.playing;
                                });
                              } else if (_playerState ==
                                  PlayerState.completed) {
                                await playAnthem();
                                setState(() {
                                  _playerState = PlayerState.playing;
                                });
                              }
                            },
                            icon: _playerState == PlayerState.playing
                                ? Icon(
                                    IconsaxOutline.pause,
                                    size: 20,
                                  )
                                : _playerState == PlayerState.paused
                                    ? Icon(
                                        IconsaxOutline.play,
                                        size: 20,
                                      )
                                    : cupertino.CupertinoActivityIndicator(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Interests',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.user.interests
                              .map((ele) => _buildInterestChip(ele))
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'MoodBoard',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildGalleryGrid(),
                      ],
                    ),
                  ),
                ],
              ),
              canPop
                  ? Positioned(
                      top: MediaQuery.of(context).padding.top +
                          10, // Adds padding for status bar
                      left: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          iconSize: 20,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    double size = 48,
    required VoidCallback onTap,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: iconColor,
        ),
        iconSize: size * 0.5,
      ),
    );
  }

  Widget _buildInterestChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE94057),
        ),
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFFFE8EA),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFFE94057),
        ),
      ),
    );
  }

  Widget _buildGalleryGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: widget.user.moodBoard!.images
          .map((url) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ))
          .toList(),
    );
  }
}
