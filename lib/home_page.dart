import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'custom_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.city = 'cairo'});
  final String city;

  @override
  State<HomePage> createState() => _HomePageState();
}

var date = DateTime.now();

class _HomePageState extends State<HomePage> {
  Map<String, String> timeMap = {};
  Map<String, String> dateMap = {};
  var now = DateFormat('DD-MM-YYYY').format(date);
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: timeMap.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                SizedBox(
                  height: size.height * 0.4,
                  width: size.width,
                  child: Container(
                    color: const Color.fromRGBO(20, 83, 105, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 30, color: Colors.black),
                          child: Text(
                            '${dateMap['day']}',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 30, color: Colors.black),
                          child: Text(
                            '${dateMap['date']}',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 30, color: Colors.black),
                          child: Text(
                            '${dateMap['month']}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomContainer(
                  size: size,
                  timeMap: timeMap['Fajr'],
                  image: const AssetImage("assets/images/fajr.jpg"),
                  title: 'Fajr',
                ),
                CustomContainer(
                  size: size,
                  timeMap: timeMap['Shrouk'],
                  image: const AssetImage("assets/images/shrouk.jpg"),
                  title: 'Shrouk',
                ),
                CustomContainer(
                  size: size,
                  timeMap: timeMap['Dhuhr'],
                  image: const AssetImage("assets/images/duhr.jpg"),
                  title: 'Dhuhr',
                ),
                CustomContainer(
                  size: size,
                  timeMap: timeMap['Asr'],
                  image: const AssetImage("assets/images/asr.jpg"),
                  title: 'Asr',
                ),
                CustomContainer(
                  size: size,
                  timeMap: timeMap['Maghrib'],
                  image: const AssetImage("assets/images/majrb.jpg"),
                  title: 'Maghrib',
                ),
                CustomContainer(
                  size: size,
                  timeMap: timeMap['Isha'],
                  image: const AssetImage("assets/images/isha.jpg"),
                  title: 'Isha',
                ),
              ],
            ),
    );
  }

  getData() async {
    var response = await http.get(
      Uri.parse(
          'https://api.aladhan.com/v1/timingsByCity/$now?country=Egypt&city=${widget.city}}'),
    );
    var data = jsonDecode(response.body); //convert jason to map
    var dataList = data['data'];
    var timings = dataList['timings'];
    var dateList = dataList['date'];
    setState(() {
      timeMap['Fajr'] = timings['Fajr'];
      timeMap['Shrouk'] = timings['Sunrise'];
      timeMap['Dhuhr'] = timings['Dhuhr'];
      timeMap['Asr'] = timings['Asr'];
      timeMap['Maghrib'] = timings['Maghrib'];
      timeMap['Isha'] = timings['Isha'];
      dateMap['date'] = dateList['hijri']['date'];
      dateMap['day'] = dateList['hijri']['weekday']['ar'];
      dateMap['month'] = dateList['hijri']['month']['ar'];
    });
  }
}
