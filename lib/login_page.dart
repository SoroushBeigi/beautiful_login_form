import 'dart:ui';

import 'package:beautiful_login_form/bg_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _startTime = 0;
  double get _elapsedTimeInSeconds => (_startTime - DateTime.now().millisecondsSinceEpoch) / 1000;
  @override
  Widget build(BuildContext context) {
    // final inputDecoration = InputDecoration(
    //   fillColor: Colors.grey[600],
    //   filled: true,
    //   border: OutlineInputBorder(
    //     borderSide: BorderSide.none,
    //     borderRadius: BorderRadius.circular(10.0),
    //   ),
    // );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<FragmentShader>(
                  future: _load(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final shader = snapshot.data!;
                      _startTime = DateTime.now().millisecondsSinceEpoch;
                      return AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) {
                            shader.setFloat(0, _elapsedTimeInSeconds);
                            shader.setFloat(1, MediaQuery.of(context).size.width);
                            shader.setFloat(2, MediaQuery.of(context).size.height);
                            return CustomPaint(
                              painter: BackgroundPainter(shader),
                            );
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<FragmentShader> _load() async {
    FragmentProgram program =
        await FragmentProgram.fromAsset('assets/shaders/bg_shader.frag');
    return program.fragmentShader();
  }
}
