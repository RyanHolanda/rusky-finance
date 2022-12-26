import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        height: 120,
        width: 150,
        child: Shimmer.fromColors(
            enabled: true,
            period: const Duration(milliseconds: 500),
            baseColor: Theme.of(context).primaryColor.withOpacity(0.1),
            highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
            child: Container(
              color: Colors.amber,
            )),
      ),
    ));
  }
}
