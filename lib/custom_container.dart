import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.size,
    required this.timeMap, required this.image,
  }) : super(key: key);

  final Size size;
  final String? timeMap;
  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 150,
      child: Stack(children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: image, fit: BoxFit.fill),
          ),
        ),
        Center(
          child: Column(
            children: [
              Text(
                '$timeMap',
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
