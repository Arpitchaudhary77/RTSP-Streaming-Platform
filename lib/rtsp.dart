import 'dart:math' as math;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:android_pip/android_pip.dart';
import 'package:android_pip/pip_widget.dart';

class RTSPPlayerScre extends StatefulWidget {
  const RTSPPlayerScre({Key? key, required this.rtspUrl}) : super(key: key);
  final String rtspUrl;

  @override
  State<RTSPPlayerScre> createState() => _RTSPPlayerScreState();
}

class _RTSPPlayerScreState extends State<RTSPPlayerScre> {
  late VlcPlayerController _vlcViewController;
  late AndroidPIP pip;
  bool pipAvailable = false;
  final List<int> aspectRatio = [16, 9];
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    pip = AndroidPIP();
    _vlcViewController = VlcPlayerController.network(
      widget.rtspUrl,
      hwAcc: HwAcc.auto,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    _checkPipAvailability();
  }

  Future<void> _checkPipAvailability() async {
    final isAvailable = await AndroidPIP.isPipAvailable;
    setState(() {
      pipAvailable = isAvailable;
    });
  }

  @override
  void dispose() {
    _vlcViewController.stop();
    _vlcViewController.dispose();
    super.dispose();
  }

  void _togglePlayback() {
    if (isPlaying) {
      _vlcViewController.pause();
    } else {
      _vlcViewController.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _refreshStream() {
    _vlcViewController.stop();
    _vlcViewController.play();
  }

  @override
  Widget build(BuildContext context) {
    return PipWidget(
      onPipMaximised: () => log("Returned from PIP"),
      onPipExited: () => log("Exited PIP Mode"),
      onPipEntered: () => log("Entered PIP Mode"),
      // What is shown during PIP mode.
      pipChild: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Transform.rotate(
            angle: 3 * math.pi / 2,
            child: VlcPlayer(
              controller: _vlcViewController,
              aspectRatio: 16 / 9,
              placeholder: const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ),
      // Full-screen view.
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('RTSP Stream Viewer'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.picture_in_picture),
              onPressed: pipAvailable
                  ? () => pip.enterPipMode(aspectRatio: aspectRatio)
                  : null,
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            // Use a refined blue gradient for a professional look.
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Video Player Container with card-like styling.
                  Card(
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Transform.rotate(
                        angle: 3 * math.pi / 2,
                        child: VlcPlayer(
                          controller: _vlcViewController,
                          aspectRatio: 16 / 9,
                          placeholder: const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Control Panel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Play/Pause Button
                      IconButton(
                        iconSize: 48,
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          color: Colors.white,
                        ),
                        onPressed: _togglePlayback,
                      ),
                      const SizedBox(width: 40),
                      // Refresh Button
                      IconButton(
                        iconSize: 48,
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        onPressed: _refreshStream,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
