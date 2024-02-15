import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/device.dart';
import '../models/home_devices.dart';

class SmartDeviceBox extends StatelessWidget {
  final Device device;
  final bool powerOn;
  final double fontSize;
  final double imageHeight;
  final bool listView;
  void Function(bool)? onChanged;

  SmartDeviceBox({
    super.key,
    required this.device,
    required this.powerOn,
    required this.fontSize,
    required this.imageHeight,
    required this.listView,
    required this.onChanged,
  });

  void deviceInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: CupertinoAlertDialog(
                content: SizedBox(
                    height: 100,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          device.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          device.description,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ))),
                actions: [
                  CupertinoButton(
                      child: Text("Назад"),
                      onPressed: () => Navigator.pop(context)),
                  CupertinoButton(
                      child: Text(
                        "Удалить",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        context
                            .read<HomeDevices>()
                            .removeFromUserDevices(device);
                        Navigator.pop(context);
                      })
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: GestureDetector(
        onLongPress: () {
          deviceInfo(context);
        },
        child: Container(
          decoration: BoxDecoration(
              color: powerOn ? Colors.grey[900] : Colors.grey[200],
              borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  device.imagePath,
                  color: powerOn ? Colors.white : Colors.black,
                  height: imageHeight,
                ),
                fontSize == 15
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  device.name,
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                      color: powerOn
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            listView == true
                                ? CupertinoSwitch(
                                    value: powerOn, onChanged: onChanged)
                                : Transform.rotate(
                                    angle: pi / 2,
                                    child: CupertinoSwitch(
                                        value: powerOn, onChanged: onChanged),
                                  )
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              device.name,
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: powerOn ? Colors.white : Colors.black),
                            ),
                          ),
                          SizedBox(
                              height: 15,
                              child: CupertinoSwitch(
                                  value: powerOn, onChanged: onChanged))
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
