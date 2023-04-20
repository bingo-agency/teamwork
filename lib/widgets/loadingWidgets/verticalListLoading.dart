import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VerticalListLoading extends StatelessWidget {
  const VerticalListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          loadingTile(context),
          loadingTile(context),
          loadingTile(context),
          loadingTile(context),
          loadingTile(context),
          loadingTile(context),
          loadingTile(context),
          loadingTile(context)
        ],
      ),
    );
  }
}

loadingTile(context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    child: Stack(
      children: [
        Row(
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0),
                    topLeft: Radius.circular(4.0),
                    bottomLeft: Radius.circular(4.0),
                  ),
                  color: Colors.grey[10],
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffd4d4d9),
                        spreadRadius: 0.2,
                        blurRadius: 1.0),
                  ],
                  border: Border.all(color: Colors.black12)),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: 100,
                        height: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                            ),
                            color: Colors.grey[10],
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xffd4d4d9),
                                  spreadRadius: 0.2,
                                  blurRadius: 1.0),
                            ],
                            border: Border.all(color: Colors.black12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 100,
                    height: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                        color: Colors.grey[10],
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xffd4d4d9),
                              spreadRadius: 0.2,
                              blurRadius: 1.0),
                        ],
                        border: Border.all(color: Colors.black12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 10,
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                            ),
                            color: Colors.grey[10],
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xffd4d4d9),
                                  spreadRadius: 0.2,
                                  blurRadius: 1.0),
                            ],
                            border: Border.all(color: Colors.black12),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 100,
                          height: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                              ),
                              color: Colors.grey[10],
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xffd4d4d9),
                                    spreadRadius: 0.2,
                                    blurRadius: 1.0),
                              ],
                              border: Border.all(color: Colors.black12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              width: 100,
              height: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  color: Colors.grey[10],
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffd4d4d9),
                        spreadRadius: 0.2,
                        blurRadius: 1.0),
                  ],
                  border: Border.all(color: Colors.black12),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
