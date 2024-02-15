import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/home_devices.dart';
import 'device_tile.dart';

class DevicesList extends StatelessWidget {
  final int index;
  const DevicesList({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final devices = context.watch<HomeDevices>().getCategoryList(index);
    return SizedBox(
      height: 220,
      child: ScrollConfiguration(
        behavior: AppScrollBehavior(),
        child: ListView.builder(
            itemCount: devices.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final device = devices[index];
              return DeviceTile(device: device);
            }),
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

