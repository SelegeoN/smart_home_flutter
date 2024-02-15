import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_ui/models/home_devices.dart';
import 'package:smart_home_ui/util/smart_device_box.dart';
import 'dart:ui';

import '../models/device.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final double horizontalPadding = 30;

  final double verticalPadding = 13;

  void powerSwitchChange(BuildContext context,bool value, Device item) {
    context.read<HomeDevices>().deviceToActive(item, value);
  }

  @override
  Widget build(BuildContext context) {
    final userDevices = context.watch<HomeDevices>().userDevices;
    final userName = context.watch<HomeDevices>().userName;
    int gridCount = context.watch<HomeDevices>().gridCount;
    double fontSize = context.watch<HomeDevices>().fontSize;
    double imageHeight = context.watch<HomeDevices>().imageHeight;
    bool listView = context.watch<HomeDevices>().listView;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/device_page'),
                    child: Image.asset(
                      'lib/icons/menu.png',
                      height: 45,
                      color: Colors.grey[800],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/intro_page');
                      context.read<HomeDevices>().logOut();
                    },
                    child: Icon(
                      Icons.logout_rounded,
                      size: 45,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),

            //приветствие
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ну привет,'),
                  Text(
                    userName.isEmpty ? 'Кто-то не ввел имя' : userName,
                    style: TextStyle(fontSize: 35),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            //устройства

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Divider(
                color: Colors.grey[400],
                thickness: 1,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Text(
                'Умные устройства',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey[800]),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: listView == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<HomeDevices>().listViewToggle();
                          },
                          icon: Icon(Icons.grid_on_outlined),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<HomeDevices>().upScaleGrid();
                          },
                          icon: Icon(Icons.exposure_minus_1),
                          color: gridCount == 2 ? Colors.grey : Colors.black,
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<HomeDevices>().listViewToggle();
                          },
                          icon: Icon(Icons.list_alt_rounded),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<HomeDevices>().downScaleGrid();
                          },
                          icon: Icon(Icons.plus_one),
                          color: gridCount == 3 ? Colors.grey : Colors.black,
                        ),
                      ],
                    ),
            ),

            listView == true
                ? Expanded(
                    child: userDevices.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              'Добавьте устройства',
                              style: TextStyle(color: Colors.grey[900]),
                            ),
                          )
                        : ListView.builder(
                            itemCount: userDevices.length,
                            padding: EdgeInsets.all(verticalPadding),
                            itemBuilder: (context, index) {
                              return SmartDeviceBox(
                                device: userDevices[index],
                                powerOn: userDevices[index].isActive,
                                fontSize: fontSize,
                                imageHeight: imageHeight,
                                listView: listView,
                                onChanged: (value) {
                                  powerSwitchChange(context,value, userDevices[index]);
                                },
                              );
                            }))
                : Expanded(
                    child: ScrollConfiguration(
                    behavior: AppScrollBehavior(),
                    child: userDevices.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              'Добавьте устройства',
                              style: TextStyle(color: Colors.grey[900]),
                            ),
                          )
                        : GridView.builder(
                            itemCount: userDevices.length,
                            padding: EdgeInsets.all(verticalPadding),
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: gridCount,
                              childAspectRatio: 1 / 1,
                            ),
                            itemBuilder: (context, index) {
                              return SmartDeviceBox(
                                device: userDevices[index],
                                powerOn: userDevices[index].isActive,
                                fontSize: fontSize,
                                imageHeight: imageHeight,
                                listView: listView,
                                onChanged: (value) {
                                  powerSwitchChange(context,value, userDevices[index]);
                                },
                              );
                            },
                          ),
                  )),
          ],
        ),
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
