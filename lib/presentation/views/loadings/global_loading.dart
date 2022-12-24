import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GlobalLoading extends StatelessWidget {
  const GlobalLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Lottie.asset('assets/loading_app_animation.json',
                  height: 150)),
          const SizedBox(
            height: 50,
          ),
          Text(AppLocalizations.of(context)!.loading)
        ],
      ),
    );
  }
}
