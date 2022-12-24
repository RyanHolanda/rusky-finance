import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingNews extends StatelessWidget {
  const LoadingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/loading_app_animation.json', height: 200);
  }
}
