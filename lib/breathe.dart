import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Breathe extends StatefulWidget {
  final String next;

  const Breathe({Key? key, required this.next}) : super(key: key);

  @override
  State<Breathe> createState() => _BreatheState();
}

class _BreatheState extends State<Breathe> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  late final AnimationController _iconController;
  late final Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _iconController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _iconAnimation =
        CurvedAnimation(parent: _iconController, curve: Curves.linear);
    configureAndStart();
  }

  Future<void> configureAndStart() async {
    _controller.duration = Duration(
        milliseconds:
            (await SharedPreferences.getInstance()).getInt('time') ?? 2500);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Center(
              child: RepaintBoundary(
                child: ScaleTransition(
                  scale: _animation,
                  child: Container(
                    width: 256,
                    height: 256,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (_controller.isAnimating) {
                        _iconController.forward();
                        _controller.stop();
                      } else {
                        _iconController.reverse();
                        _controller.repeat(reverse: true);
                      }
                    },
                    icon: AnimatedIcon(
                        icon: AnimatedIcons.pause_play,
                        progress: _iconAnimation),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, widget.next),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
