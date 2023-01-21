import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        featuredLoadingCard(context),
        featuredLoadingCard(context),
        featuredLoadingCard(context),
        featuredLoadingCard(context),
        featuredLoadingCard(context),
        featuredLoadingCard(context),
        featuredLoadingCard(context),
      ],
    );
  }
}

Widget featuredLoadingCard(context) {
  return Container(
    margin: const EdgeInsets.only(right: 3),
    width: 350,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey[20],
      borderRadius: BorderRadius.circular(8),
    ),
    child: Stack(
      children: [
        SizedBox(
            child: Container(
              //here could chbe
              child: SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0),
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                    ),
                    color: Colors.grey[20],
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffd4d4d9),
                          spreadRadius: 0.1,
                          blurRadius: 0.1),
                    ],
                    border: Border.all(color: Colors.black12),
                  ),
                ),
                width: 50,
                height: 10,
              ),
            ),
            width: 350,
            height: 350),
        Positioned(
          right: 15,
          top: 15,
          child: Card(
            color: Colors.grey[20],
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0),
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                    ),
                    color: Colors.grey[20],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.2,
                          blurRadius: 1.0),
                    ],
                    border: Border.all(color: Colors.black12),
                  ),
                ),
                width: 70,
                height: 15,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.white54,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4.0),
                              bottomRight: Radius.circular(4.0),
                              topLeft: Radius.circular(4.0),
                              bottomLeft: Radius.circular(4.0),
                            ),
                            color: Colors.grey[10],
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffd4d4d9),
                                  spreadRadius: 0.1,
                                  blurRadius: 0.1),
                            ],
                            border: Border.all(color: Colors.black12),
                          ),
                        ),
                        width: 120,
                        height: 12,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                            ),
                            color: Colors.grey[10],
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffd4d4d9),
                                  spreadRadius: 0.1,
                                  blurRadius: 0.2),
                            ],
                            border: Border.all(color: Colors.black12),
                          ),
                        ),
                        width: 70,
                        height: 12,
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                          color: Colors.grey[20],
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffd4d4d9),
                                spreadRadius: 0.1,
                                blurRadius: 0.1),
                          ],
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      width: 70,
                      height: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
