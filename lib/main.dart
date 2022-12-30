import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentDuration = 5; // default meditation duration in minutes
  String?
      _currentMeditationUrl; // url of the currently playing meditation audio
  bool _isPlaying =
      false; // flag to track whether the meditation audio is currently playing

  // function to fetch the meditation audio url from the API
  Future<void> _fetchMeditationAudio() async {
    // replace API_URL with the actual URL of your meditation audio API
    final response =
        await http.get(Uri.https('https://music.youtube.com', 'api/tracks'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _currentMeditationUrl = data['url'];
      });
    } else {
      throw Exception('Failed to load meditation audio');
    }
  }

  void _incrementDuration() {
    setState(() {
      _currentDuration++;
    });
  }

  void _decrementDuration() {
    setState(() {
      _currentDuration--;
    });
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Duration: $_currentDuration minutes'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _decrementDuration,
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _incrementDuration,
              ),
            ],
          ),
          SizedBox(height: 20),
          _isPlaying
              ? IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: _togglePlay,
                )
              : IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: _togglePlay,
                ),
        ],
      ),
    );
  }
}
