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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('RTSP Stream Viewer'),
      ),
      body: Center(
        child: VlcPlayer(
          controller: _vlcViewController,
          aspectRatio: MediaQuery.of(context).size.aspectRatio, // Full-screen aspect ratio
          placeholder: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
