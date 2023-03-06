import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.size,
    required this.timeMap,
    required this.image, required this.title,
  }) : super(key: key);

  final Size size;
  final String? timeMap;
  final AssetImage image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 200,
      child: Stack(children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: image, fit: BoxFit.fill),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: const TextStyle(color: Colors.black, fontSize: 25),
              child: Text(
                '$title :',
              ),
            ),
            Center(
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.black, fontSize: 20),
                child: Text(
                  '$timeMap',
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
