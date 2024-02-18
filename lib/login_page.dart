import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      fillColor: Colors.grey[600],
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              color: Colors.grey[900]!.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(decoration: inputDecoration).animate().slideX(
                          duration: 1.seconds,
                        ),
                    TextFormField(decoration: inputDecoration,)
                        .animate()
                        .slideX(delay: 1.seconds, duration: 1.seconds),
                    ElevatedButton(onPressed: () {}, child: const Text('Login'))
                        .animate()
                        .fadeIn(delay: 2.seconds, duration: 1.seconds)
                        .shimmer(
                            duration: 10.seconds,
                            color: Colors.grey.withOpacity(0.6)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
