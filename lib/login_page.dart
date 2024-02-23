import 'dart:ui';

import 'package:beautiful_login_form/bg_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  double get _elapsedTimeInSeconds =>
      (_startTime - DateTime.now().millisecondsSinceEpoch) / 1000;

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      hintStyle: const TextStyle(color: Colors.grey,),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
    const textStyle = TextStyle(color: Colors.white,letterSpacing: 2);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
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
                            shader.setFloat(
                                1, MediaQuery.of(context).size.width);
                            shader.setFloat(
                                2, MediaQuery.of(context).size.height);
                            return CustomPaint(
                              painter: BackgroundPainter(shader),
                            );
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ),
            Center(
              //TODO: decide to use or not to use blur
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
   margin: EdgeInsets.symmetric(horizontal:4.w),
                  child: Card(
                      color: Colors.black.withOpacity(0.3),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical:6.h,horizontal:5.w),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  decoration: inputDecoration.copyWith(hintText: 'Enter your email address'),
                                  style: textStyle,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                TextFormField(
                                  decoration: inputDecoration.copyWith(hintText: 'Enter your password'),
                                  style: textStyle,
                                  keyboardType:TextInputType.visiblePassword,
                                  obscureText: true,
                                ),
                                SizedBox(height: 4.h),
                                SizedBox(
                                  width: 40.w,
                                    height:7.5.h,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Login'),
                                  ).animate().fadeIn(delay: 2.seconds,duration: 1.seconds,curve: Curves.easeIn),
                                )
                              ],
                            )),
                      ),).animate().slideX(duration: 2.seconds,curve: Curves.ease),
                ),
              ),
            ),
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
