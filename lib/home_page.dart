import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'custom_container.dart';
import 'custom_grid_view_element.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.city = 'cairo'});
  final String city;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var differenceBetweenPrayers = [];
  List<String> timeMap = [];
  Map<String, String> dateMap = {};
  Duration diff = const Duration();
  String image = "";
  String fajrImage = "assets/images/fajr.jpg";
  String shroukImage = "assets/images/shrouk.jpg";
  String dhuhrImage = "assets/images/duhr.jpg";
  String asrImage = "assets/images/asr.jpg";
  String maghribImage = "assets/images/majrb.jpg";
  String ishaImage = "assets/images/isha.jpg";

  List<String> pray = [
    'Fajr',
    'Shrouk',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List<String> iconList = [
      "assets/images/fajrIcon.jpg",
      "assets/images/Elshrouk.png",
      "assets/images/Eldhuhr.png",
      "assets/images/Elasr.png",
      "assets/images/ElMaghrib.png",
      "assets/images/IshaIcon.jpg",
    ];
    List<String> praynum = [
      'first',
      'second',
      'third',
      'fourth',
      'fifth',
      'sixth',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: timeMap.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            SizedBox(
                              height: size.height * 0.70,
                              width: size.width,
                              child: Container(
                                constraints: const BoxConstraints.expand(),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    bottomRight: Radius.circular(100),
                                  ),
                                  image: DecorationImage(
                                      image: AssetImage(getImage(compare())),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${compare()} after ${formatDuration(diff)}',
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 125,
                          width: size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: CustomContainer(
                                  icon: iconList[index],
                                  pray: pray[index],
                                  praynum: praynum[index],
                                  praytime: timeMap[index],
                                ),
                              );
                            }),
                            itemCount: 6,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.count(
                      childAspectRatio: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: [
                        CustomGridViewElement(
                          content: dateMap['day']!,
                          title: 'Day',
                        ),
                        CustomGridViewElement(
                          content: dateMap['date']!,
                          title: 'Time',
                        ),
                        CustomGridViewElement(
                          content: dateMap['month']!,
                          title: 'Month',
                        ),
                        CustomGridViewElement(
                          content: widget.city,
                          title: 'Location',
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  getData() async {
    var date = DateTime.now();
    var now = DateFormat('DD-MM-YYYY').format(date);
    var response = await http.get(
      Uri.parse(
          'https://api.aladhan.com/v1/timingsByCity/$now?country=Egypt&city=${widget.city}}'),
    );
    var data = jsonDecode(response.body); //convert jason to map
    var dataList = data['data'];
    var timings = dataList['timings'];
    var dateList = dataList['date'];
    setState(() {
      timeMap.add(timings['Fajr']);
      timeMap.add(timings['Sunrise']);
      timeMap.add(timings['Dhuhr']);
      timeMap.add(timings['Asr']);
      timeMap.add(timings['Maghrib']);
      timeMap.add(timings['Isha']);
      dateMap['date'] = dateList['hijri']['date'];
      dateMap['day'] = dateList['hijri']['weekday']['ar'];
      dateMap['month'] = dateList['hijri']['month']['ar'];
    });
  }

  getDate(String date) {
    var time = date.split(":");
    int hours = int.parse(time[0]);
    int minutes = int.parse(time[1]);
    TimeOfDay now = TimeOfDay(hour: hours, minute: minutes);
    return now;
  }

  getDateTime(TimeOfDay time) {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  compare() {
    String current = '';

    var now = getDateTime(getDate(DateFormat.Hm().format(DateTime.now()))).hour;

    setState(() {
      for (int i = 0; i < timeMap.length - 1; i++) {
        if (now > getDateTime(getDate(timeMap[i])).hour &&
            now <= getDateTime(getDate(timeMap[i + 1])).hour) {
          diff = getDateTime(getDate(timeMap[i + 1])).difference(
              getDateTime(getDate(DateFormat.Hm().format(DateTime.now()))));
          current = pray[i + 1];
        }
      }
      if (now > getDateTime(getDate(timeMap[5])).hour ||
          now <= getDateTime(getDate(timeMap[0])).hour) {
        current = pray[0];
      }
    });
    return current;
  }

  getImage(String name) {
    setState(() {
      if (name == 'Fajr') {
        image = fajrImage;
      } else if (name == 'Shrouk') {
        image = shroukImage;
      } else if (name == 'Dhuhr') {
        image = dhuhrImage;
      } else if (name == 'Asr') {
        image = asrImage;
      } else if (name == 'Maghrib') {
        image = maghribImage;
      } else if (name == 'Isha') {
        image = ishaImage;
      } else {
        image = dhuhrImage;
      }
    });
    return image;
  }

  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes";
  }
}
