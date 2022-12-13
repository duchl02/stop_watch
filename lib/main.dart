import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stop Watch",
      theme: ThemeData(primaryColor: Colors.amber),
      home: MyHomePage(title: "Stop Watch"),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  int _countSeconds = 0;
  Duration timeDuration = Duration.zero;
  bool _timerRunning = false;

  void initState() {
    super.initState();
  }

  void startTimer() {
    _timerRunning = true;
    _timer?.cancel();
    _countSeconds = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countSeconds++;
        print(timeDuration);
        timeDuration = Duration(seconds: _countSeconds);
      });
    });
  }

  void stopTime() {
    _timerRunning = false;
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          // fit: StackFit.loose,
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(
                  strokeWidth: 20,
                  value: _countSeconds.remainder(60) / 60,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timeDuration.inMinutes.toString(),
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
                Text(":", style: Theme.of(context).textTheme.headline1),
                Text(
                  timeDuration.inSeconds.remainder(60).toString().padLeft(2, "0"),
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_timerRunning) {
            setState(() {
              stopTime();
            });
          } else {
            setState(() {
              startTimer();
            });
          }
        },
        child: Icon(_timerRunning ? Icons.play_arrow : Icons.pause),
      ),
    );
  }
}
