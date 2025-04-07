import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class UnavailableView extends StatefulWidget {
  const UnavailableView({super.key});

  @override
  State<UnavailableView> createState() => _UnavailableViewState();
}

class _UnavailableViewState extends State<UnavailableView> {
  final riveFileName = 'monster-game.riv';
  late Artboard _artboard;
  late RiveAnimationController _controller;

  void _loadRiveFile() async {
    final bytes = await rootBundle
        .load('animation/$riveFileName'); // Load the animation file
    final file = RiveFile.import(bytes);

    _artboard = file.mainArtboard;
    _controller = SimpleAnimation('Thumbnail');
    setState(() {
      _artboard.addController(_controller);
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    _loadRiveFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Center(
        child: Column(
          children: [
            const Expanded(
              flex: 5,
              child: SizedBox(),
            ),
            Expanded(
              flex: 9,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.isActiveChanged.addListener(() {
                          // IF 'IsPosition1Pressed' --> State = Position1 -    // Note : There are few resources about LISTENERS
                        });
                        _controller = SimpleAnimation('Jump');
                        _artboard.addController(_controller);
                      });
                    },
                    child: Rive(
                      //RIVE
                      artboard: _artboard,
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 36, right: 36),
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "This product is unavailable.",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Unfortunately, this product might be out of stock or unavailable to order.",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: () {
                  SnackBar snackBar = const SnackBar(
                    content: Text("Tapped! (See What's New) "),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: CustomPaint(
                    painter: CustomShape(),
                    child: const Center(
                        child: Text(
                      "See What's New",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black),
                    )),
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 5,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill; // WHITE RECTANGLE
    paint.strokeWidth = 1;

    final paint2 = Paint();
    paint2.color = Colors.black;
    paint2.style = PaintingStyle.stroke; // BORDER
    paint2.strokeWidth = 2.4;

    final paint3 = Paint();
    paint3.color = const Color(0xFFD7FC70);
    paint3.style = PaintingStyle.fill; // BACKGROUND RECTANGLE
    paint3.strokeWidth = 1;
    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 1.5,
        height: size.height * 0.72,
      ),
      const Radius.circular(15),
    );
    RRect fullRect2 = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 1.1 / 2, size.height * 1.1 / 2),
        width: size.width * 1.5,
        height: size.height * 0.72,
      ),
      const Radius.circular(15),
    );
    canvas.drawRRect(fullRect2, paint3);
    canvas.drawRRect(fullRect, paint);
    canvas.drawRRect(fullRect, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
