// import 'dart:io';
// import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
// import 'package:flutter/material.dart';
// import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class RTSPRecorderPage extends StatefulWidget {
//   const RTSPRecorderPage({Key? key}) : super(key: key);
//
//   @override
//   State<RTSPRecorderPage> createState() => _RTSPRecorderPageState();
// }
//
// class _RTSPRecorderPageState extends State<RTSPRecorderPage> {
//   bool isRecording = false;
//   String? savedPath;
//
//   Future<void> _startRecording() async {
//     await Permission.storage.request();
//
//     final dir = await getExternalStorageDirectory();
//     final filePath = '${dir!.path}/stream_record_${DateTime.now().millisecondsSinceEpoch}.mp4';
//
//     const rtspUrl = 'rtsp://your-ip/live/stream'; // 👈 Replace with your actual RTSP stream
//
//     final ffmpegCommand = "-i $rtspUrl -c copy -t 00:01:00 $filePath"; // record 1 minute
//
//     FFmpegKit.executeAsync(ffmpegCommand, (session) async {
//       final returnCode = await session.getReturnCode();
//       if (ReturnCode.isSuccess(returnCode)) {
//         setState(() {
//           isRecording = false;
//           savedPath = filePath;
//         });
//         debugPrint("Recording complete: $filePath");
//       } else {
//         debugPrint("Recording failed.");
//       }
//     });
//
//     setState(() {
//       isRecording = true;
//     });
//   }
//
//   void _stopRecording() {
//     FFmpegKit.cancel();
//     setState(() {
//       isRecording = false;
//     });
//     debugPrint("Recording stopped manually.");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("RTSP Stream Recorder")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton.icon(
//               icon: Icon(isRecording ? Icons.stop : Icons.fiber_manual_record),
//               label: Text(isRecording ? "Stop Recording" : "Start Recording"),
//               onPressed: isRecording ? _stopRecording : _startRecording,
//             ),
//             if (savedPath != null)
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Text("Saved at: $savedPath"),
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }
