import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../view_data_for_firebase_with_loading.dart';

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  final String urlVideo;
  final String videoId;
  final String coursesId;
   VideoApp({super.key, required this.urlVideo, required this.videoId, required this.coursesId});

  @override
  _VideoAppState createState() => _VideoAppState(urlVideo ,videoId ,coursesId);
}

class _VideoAppState extends State<VideoApp> {
  final String urlVideo;
   final String videoId;
   final String coursesId;
  late VideoPlayerController _controller;


  _VideoAppState( this.urlVideo, this.videoId, this.coursesId);
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        urlVideo))
    // _controller = VideoPlayerController.asset('assets/video/introfirebase.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
  }
  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot<Map<String, dynamic>>> getData =
    FirebaseFirestore.instance.collection("courses").doc(coursesId).collection("video").doc(videoId).get();
    return Scaffold(
      appBar: AppBar(
        title: ViewDataForFireBaseWithLoading(
          future: getData,
          widgetView: (snapshot){
            return Text( snapshot.data!.data()['name']);
          },
        )
    ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    // Add a Slider for video navigation
                    Positioned(
                      bottom: -10,
                      left: 0,
                      right: 0,
                      child: Slider(
                        value: _controller.value.position.inSeconds.toDouble(),
                        min: 0,
                        max: _controller.value.duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _controller.seekTo(Duration(seconds: value.toInt()));
                          });

                        },
                      ),
                    ),
                    // Display current time
                    Positioned(
                      bottom: -10,
                      right: 25,
                      child: Text(
                        '${_controller.value.position.inHours}:${_controller.value.position.inMinutes.remainder(60)}:${_controller.value.position.inSeconds.remainder(60)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
                  : Container(),
            ),
          ),
          // ... (existing code)
        ],
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });

          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}