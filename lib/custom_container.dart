import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.icon,
    required this.praynum,
    required this.pray,
    required this.praytime,
  }) : super(key: key);

  final String icon;
  final String praynum;
  final String pray;
  final String praytime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 170,
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 60,
              height: 50,
            ),
            Text(
              'The $praynum prayer time',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              '$pray at $praytime',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
