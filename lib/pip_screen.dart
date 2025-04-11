import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class RTSPPlayerScreen extends StatefulWidget {
  const RTSPPlayerScreen({super.key, required this.rtspUrl});
  final String rtspUrl;

  @override
  _RTSPPlayerScreenState createState() => _RTSPPlayerScreenState();
}

class _RTSPPlayerScreenState extends State<RTSPPlayerScreen> {
  late VlcPlayerController _vlcViewController;

  @override
  void initState() {
    super.initState();
    _vlcViewController = VlcPlayerController.network(
      widget.rtspUrl,
      hwAcc: HwAcc.auto,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    _vlcViewController.stop();
    _vlcViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the full screen size.
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // Set background to black so there’s no white border.
      backgroundColor: Colors.black,
      // Removing the app bar for a full-screen experience.
      body: SizedBox.expand(
        // FittedBox with BoxFit.cover makes the video cover the entire screen.
        child: FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          child: SizedBox(
            // The inner SizedBox uses the native 16:9 dimensions.
            width: size.width,
            height: size.width * 9 / 16,
            child: VlcPlayer(
              controller: _vlcViewController,
              // Optionally set aspectRatio; here it matches the 16:9 video.
              aspectRatio: 16 / 9,
              placeholder: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
