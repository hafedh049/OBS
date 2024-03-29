import 'package:frontend/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: scaffoldColor, body: Center(child: LottieBuilder.asset("assets/lotties/loading.json")));
  }
}
