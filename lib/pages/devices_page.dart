import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_ui/models/home_devices.dart';
import 'package:smart_home_ui/util/devices_list.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context
        .watch<HomeDevices>()
        .categories;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60)),
                  color: Colors.grey[200]
              ),
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/home_page'),
                icon: Icon(Icons.home_max_outlined),),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category.name, style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.grey[800]),),
                      DevicesList(index: category.index)
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}

