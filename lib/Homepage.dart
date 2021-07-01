import 'dart:io';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:auto_animated/auto_animated.dart';

import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/DBprovider.dart';
import 'package:scheduler/bgblobs.dart';
import 'package:scheduler/circularpercentindicator.dart';
import 'package:scheduler/clockpainter.dart';
import 'package:scheduler/detailspage.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime selecteddate;
  late ScrollController datescrollcontroller;
  var selecteddatefromcalender = DateTime.now();
  late var currentinfo;

  // double get screenwidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    selecteddate = selecteddatefromcalender;
    datescrollcontroller = ScrollController(initialScrollOffset: 1650 - 131);
    currentinfo = Provider.of<DBprovider>(context, listen: false).todayinfo;
    print(currentinfo);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.withOpacity(0.7),
        elevation: 0,
        onPressed: () {
          _showPicker(context);
        },
        child: cupertino.Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Stack(
        children: [
          const blobsbg(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Colors.amber,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                      height: MediaQuery.of(context).size.height - 60,
                      width: MediaQuery.of(context).size.width - 30,
                      color: Colors.white24,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Container(
                              // width: 30,
                              height: 70,
                              alignment: Alignment.center,
                              // color: Colors.amber,
                              child: GestureDetector(
                                onTap: () {
                                  var tempdate;
                                  // cupertino.showCupertinoDialog(
                                  //     context: context,
                                  //     builder: (context) => Container(
                                  //           color: Colors.white,
                                  //           child:
                                  //               cupertino.CupertinoDatePicker(
                                  //             mode: cupertino
                                  //                 .CupertinoDatePickerMode.date,
                                  //             onDateTimeChanged: (value) {
                                  //               selecteddatefromcalender =
                                  //                   value;
                                  //             },
                                  //             initialDateTime: selecteddate,
                                  //             // backgroundColor: Colors.white24,
                                  //           ),
                                  //         ));

                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext builder) {
                                        return Container(
                                            height: MediaQuery.of(context)
                                                    .copyWith()
                                                    .size
                                                    .height /
                                                3,
                                            child:
                                                cupertino.CupertinoDatePicker(
                                              initialDateTime: selecteddate,
                                              onDateTimeChanged:
                                                  (DateTime newdate) {
                                                tempdate = newdate;
                                                print(tempdate);
                                              },
                                              use24hFormat: true,
                                              // minimumYear: 2020,
                                              // maximumYear: 2023,
                                              // minuteInterval: 1,
                                              mode: cupertino
                                                  .CupertinoDatePickerMode.date,
                                            ));
                                      }).then((value) async {
                                    print(
                                        '<<<<<<<<<<<<<<<<<object>>>>>>>>>>>>>>>>>');
                                    print(tempdate);
                                    selecteddatefromcalender =
                                        tempdate ?? selecteddatefromcalender;
                                    selecteddate = tempdate ?? selecteddate;
                                    currentinfo = await Provider.of<DBprovider>(
                                            context,
                                            listen: false)
                                        .fetchentrybydate(
                                            DateFormat('dd-MM-yyyy')
                                                .format(selecteddate));

                                    datescrollcontroller.animateTo(1650 - 131,
                                        duration: Duration(milliseconds: 700),
                                        curve: Curves.easeOutCirc);

                                    setState(() {});
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      DateFormat.MMMM().format(selecteddate),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black87,
                                          fontSize: 25),
                                    ),
                                    Icon(Icons.unfold_more)
                                  ],
                                ),
                              )),
                          Container(
                            height: 100,
                            child: LiveList(
                              itemBuilder: (context, index, animation) =>
                                  Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: GestureDetector(
                                  onTap: () async {
                                    selecteddate = selecteddatefromcalender
                                        .add(Duration(days: index - 15));
                                    currentinfo = await Provider.of<DBprovider>(
                                            context,
                                            listen: false)
                                        .fetchentrybydate(
                                            DateFormat('dd-MM-yyyy')
                                                .format(selecteddate));
                                    setState(() {});
                                  },
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: Container(
                                      // height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: !selecteddate
                                                          .difference(
                                                              selecteddatefromcalender)
                                                          .inDays
                                                          .isNegative &&
                                                      selecteddate.difference(selecteddatefromcalender).inHours >
                                                          20 &&
                                                      selecteddate.difference(selecteddatefromcalender).inDays + 1 ==
                                                          index - 14 ||
                                                  ((selecteddate
                                                              .difference(
                                                                  selecteddatefromcalender)
                                                              .inDays
                                                              .isNegative ||
                                                          selecteddate
                                                                  .difference(
                                                                      selecteddatefromcalender)
                                                                  .inHours <
                                                              20) &&
                                                      selecteddate
                                                              .difference(
                                                                  selecteddatefromcalender)
                                                              .inDays ==
                                                          index - 15)
                                              ? RadialGradient(
                                                  center: Alignment.topLeft,
                                                  colors: [
                                                    Colors.white54,
                                                    Colors.transparent
                                                  ],
                                                  radius: 6)
                                              : null),
                                      alignment: Alignment.center,
                                      child: Text(
                                        selecteddatefromcalender
                                            .add(Duration(days: index - 15))
                                            .day
                                            .toString(),
                                        style: !selecteddate
                                                        .difference(
                                                            selecteddatefromcalender)
                                                        .inDays
                                                        .isNegative &&
                                                    selecteddate
                                                            .difference(
                                                                selecteddatefromcalender)
                                                            .inHours >
                                                        20 &&
                                                    selecteddate
                                                                .difference(
                                                                    selecteddatefromcalender)
                                                                .inDays +
                                                            1 ==
                                                        index - 14 ||
                                                ((selecteddate
                                                            .difference(
                                                                selecteddatefromcalender)
                                                            .inDays
                                                            .isNegative ||
                                                        selecteddate
                                                                .difference(
                                                                    selecteddatefromcalender)
                                                                .inHours <
                                                            20) &&
                                                    selecteddate
                                                            .difference(
                                                                selecteddatefromcalender)
                                                            .inDays ==
                                                        index - 15)
                                            ? TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black)
                                            : TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black45),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              itemCount: 31,
                              controller: datescrollcontroller,
                              physics: BouncingScrollPhysics(),
                              showItemDuration: Duration(milliseconds: 750),
                              reAnimateOnVisibility: true,
                              addAutomaticKeepAlives: true,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                              child: CircularPercentIndicator(
                                radius: 130.0,
                                animation: true,
                                animationDuration: 1200,
                                animateFromLastPercent: true,
                                lineWidth: 15.0,
                                percent: (8 - currentinfo.length) / 8,
                                center: new Text(
                                  (8 - currentinfo.length).toString() +
                                      '\nHours\nFree',
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                circularStrokeCap: CircularStrokeCap.butt,
                                backgroundColor: Colors.red.withOpacity(0.8),
                                progressColor: Colors.white,
                              )),
                          Container(
                            // color: Colors.black,
                            height: 475,
                            width: MediaQuery.of(context).size.width,
                            child: LiveList(
                              padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
                              physics: BouncingScrollPhysics(),
                              reAnimateOnVisibility: false,
                              delay: Duration(seconds: 0),
                              showItemDuration: Duration(milliseconds: 750),
                              itemBuilder: (context, index, animation) =>
                                  SlideTransition(
                                position: Tween<Offset>(
                                        begin: Offset(0, 0.1), end: Offset.zero)
                                    .animate(animation),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: Card(
                                    child: OpenContainer(
                                      transitionDuration: Duration(seconds: 1),
                                      closedColor: Colors.transparent,
                                      middleColor: Colors.transparent,
                                      openColor: Colors.transparent,
                                      closedShape: RoundedRectangleBorder(
                                          borderRadius:
                                              cupertino.BorderRadius.circular(
                                                  20)),
                                      closedElevation: 0,
                                      openElevation: 0,
                                      closedBuilder: (context, action) {
                                        return GestureDetector(
                                          onTap: () async {
                                            action();
                                          },
                                          child: AnimatedContainer(
                                              duration: Duration(seconds: 1),
                                              height: 100,
                                              color: !checkbusy(
                                                      index, currentinfo)
                                                  ? Colors.white12
                                                  : Colors.red.withOpacity(0.6),
                                              child: Row(
                                                children: [
                                                  clockwidget(
                                                    color: Colors.black,
                                                    time: index + 9,
                                                  ),
                                                  Text(
                                                    '${index + 9 > 12 ? index + 9 - 12 : index + 9}:00 ~ ${index + 1 + 9 > 12 ? index + 1 + 9 - 12 : index + 1 + 9}:00',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                  checkbusy(index, currentinfo)
                                                      ? Expanded(
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                  right: 20,
                                                                  top: 30,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await Provider.of<DBprovider>(
                                                                              context,
                                                                              listen: false)
                                                                          .deleteentry(
                                                                        DateFormat('dd-MM-yyyy').format(selecteddate) +
                                                                            NumberFormat('00').format(index +
                                                                                9),
                                                                      );
                                                                      currentinfo = await Provider.of<DBprovider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .fetchentrybydate(
                                                                              DateFormat('dd-MM-yyyy').format(selecteddate));
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete_outline_sharp,
                                                                      size: 40,
                                                                    ),
                                                                  ))
                                                            ],
                                                          ),
                                                        )
                                                      : cupertino.Container()
                                                ],
                                              )),
                                        );
                                      },
                                      openBuilder: (context, action) {
                                        var temp;
                                        for (var item in currentinfo) {
                                          if (int.parse(item['time']) ==
                                              (index + 9)) {
                                            temp = item;
                                          }
                                        }
                                        return detailspage(
                                          date: selecteddate,
                                          time: index + 9,
                                          info: temp,
                                        );
                                      },
                                      onClosed: (data) async {
                                        currentinfo =
                                            await Provider.of<DBprovider>(
                                                    context,
                                                    listen: false)
                                                .fetchentrybydate(
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(selecteddate));
                                        setState(() {});
                                      },
                                    ),
                                    color: Colors.transparent,
                                    borderOnForeground: true,
                                    clipBehavior: Clip.hardEdge,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            width: 1,
                                            color: Colors.white,
                                            style: BorderStyle.solid)),
                                  ),
                                ),
                              ),
                              itemCount: 8,
                            ),
                          )
                        ],
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  bool checkbusy(int index, currentinfo) {
    // print(currentinfo);
    // print(currentinfo['time'].toString());
    for (var item in currentinfo) {
      // print(index + 9);
      // print('${item['time']}');
      if (index + 9 == int.parse(item['time'])) {
        return true;
      }
    }
    return false;
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () async {
                        var temp = await _imgFromGallery();
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) => Column(
                              mainAxisAlignment:
                                  cupertino.MainAxisAlignment.center,
                              mainAxisSize: cupertino.MainAxisSize.min,
                              children: [
                                Container(
                                  child: cupertino.Image.file(temp),
                                ),
                                Padding(
                                  padding: cupertino.EdgeInsets.fromLTRB(
                                      0, 30, 0, 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      cupertino.Navigator.of(context).pop();
                                    },
                                    child: cupertino.Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                )
                              ]),
                        );
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      var temp = await _imgFromCamera();
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => Column(
                            mainAxisAlignment:
                                cupertino.MainAxisAlignment.center,
                            mainAxisSize: cupertino.MainAxisSize.min,
                            children: [
                              Container(
                                child: cupertino.Image.file(temp),
                              ),
                              Padding(
                                padding:
                                    cupertino.EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    cupertino.Navigator.of(context).pop();
                                  },
                                  child: cupertino.Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              )
                            ]),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<File> _imgFromCamera() async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 20);

    return File(image!.path);
  }

  _imgFromGallery() async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 20);

    return File(image!.path);
  }
}
