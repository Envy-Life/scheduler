import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/DBprovider.dart';
import 'package:scheduler/bgblobs.dart';

class detailspage extends StatefulWidget {
  var date;
  var time;
  var info;
  detailspage({Key? key, this.date, this.time, this.info}) : super(key: key);

  @override
  _detailspageState createState() => _detailspageState();
}

class _detailspageState extends State<detailspage> {
  TextEditingController first_name_controller = TextEditingController();
  TextEditingController last_name_controller = TextEditingController();
  TextEditingController phone_no_controller = TextEditingController();
  FocusNode lastname_node = FocusNode();
  FocusNode phoneno_node = FocusNode();

  @override
  void initState() {
    first_name_controller.text = widget.info?['first_name'] ?? '';
    last_name_controller.text = widget.info?['last_name'] ?? '';
    phone_no_controller.text = widget.info?['phone_no'] ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          blobsbg(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white38,
                      ),
                      height: MediaQuery.of(context).size.height * 0.42,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 20,
                              sigmaY: 20,
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Container(
                                    // height: 70,

                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextFormField(
                                      controller: first_name_controller,
                                      autofocus: false,
                                      autocorrect: true,
                                      cursorColor: Colors.white,
                                      cursorHeight: 35,
                                      style: TextStyle(fontSize: 26),
                                      onEditingComplete: () {
                                        lastname_node.requestFocus();
                                      },
                                      // expands: true,

                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                        labelText: 'First Name',

                                        // hintText: 'First Name',
                                        // hintStyle: TextStyle(
                                        //     fontSize: 26,
                                        //     fontWeight: FontWeight.w500,
                                        //     color: Colors.black38),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 1)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.white70,
                                                width: 1)),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(20, 40, 0, 0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Container(
                                    // height: 70,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextFormField(
                                      focusNode: lastname_node,
                                      controller: last_name_controller,
                                      autocorrect: true,
                                      cursorColor: Colors.white,
                                      cursorHeight: 35,
                                      style: TextStyle(fontSize: 26),
                                      onEditingComplete: () {
                                        phoneno_node.requestFocus();
                                      },
                                      // expands: true,

                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                        labelText: 'Last Name',

                                        // hintText: 'First Name',
                                        // hintStyle: TextStyle(
                                        //     fontSize: 26,
                                        //     fontWeight: FontWeight.w500,
                                        //     color: Colors.black38),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 1)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.white70,
                                                width: 1)),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(20, 40, 0, 0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Container(
                                    // height: 70,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      autocorrect: true,
                                      validator: (value) {
                                        if (value!.isNotEmpty &&
                                            validateMobile(value)) {
                                          return null;
                                        } else {
                                          return 'Enter Valid Phone number';
                                        }
                                      },
                                      focusNode: phoneno_node,
                                      controller: phone_no_controller,
                                      cursorColor: Colors.white,
                                      cursorHeight: 35,
                                      style: TextStyle(fontSize: 26),
                                      onEditingComplete: () {
                                        Provider.of<DBprovider>(context,
                                                listen: false)
                                            .addentry(
                                                DateFormat('dd-MM-yyyy')
                                                        .format(widget.date) +
                                                    NumberFormat('00')
                                                        .format(widget.time),
                                                first_name_controller.text,
                                                last_name_controller.text,
                                                phone_no_controller.text);
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      // expands: true,

                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                        labelText: 'Phone number',

                                        // hintText: 'First Name',
                                        // hintStyle: TextStyle(
                                        //     fontSize: 26,
                                        //     fontWeight: FontWeight.w500,
                                        //     color: Colors.black38),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 1)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.white70,
                                                width: 1)),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(20, 40, 0, 0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500),
                              ),
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.4),
                                      blurRadius: 10.0,
                                      spreadRadius: 5.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.red[600]!,
                                      Colors.red[400]!
                                    ],
                                    center: Alignment.bottomCenter,
                                    radius: 1,
                                  )),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<DBprovider>(context, listen: false)
                                .addentry(
                                    DateFormat('dd-MM-yyyy')
                                            .format(widget.date) +
                                        NumberFormat('00').format(widget.time),
                                    first_name_controller.text,
                                    last_name_controller.text,
                                    phone_no_controller.text);
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600),
                              ),
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(0.4),
                                      blurRadius: 10.0,
                                      spreadRadius: 5.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.green[600]!,
                                      Colors.green[400]!
                                    ],
                                    center: Alignment.bottomCenter,
                                    radius: 1,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  bool validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{0,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
