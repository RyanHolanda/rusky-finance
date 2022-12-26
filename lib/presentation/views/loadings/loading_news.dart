import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingNews extends StatelessWidget {
  const LoadingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: ListTile(
                title: Shimmer.fromColors(
                    period: const Duration(milliseconds: 500),
                    baseColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    highlightColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: Colors.red,
                          height: 20,
                          width: 150,
                        ),
                      ),
                    )),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Shimmer.fromColors(
                      period: const Duration(milliseconds: 500),
                      baseColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      highlightColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            color: Colors.red,
                            height: 20,
                            width: 80,
                          ),
                        ),
                      )),
                ),
                trailing: SizedBox(
                  height: 70,
                  width: 70,
                  child: Shimmer.fromColors(
                      period: const Duration(milliseconds: 500),
                      baseColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      highlightColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            color: Colors.red,
                            height: 70,
                            width: 70,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
