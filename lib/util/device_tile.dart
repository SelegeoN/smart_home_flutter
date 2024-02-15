import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_ui/models/device.dart';
import 'package:smart_home_ui/models/home_devices.dart';

class DeviceTile extends StatelessWidget {
  final Device device;

  const DeviceTile({super.key, required this.device});

  void addToUserDevices(BuildContext context){
    showDialog(context: context, builder: (context)=>BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
      child: AlertDialog(
        content: SizedBox(height: 50,child: Center(child: Text("Точно добавить ${device.name}?"))),
        actions: [
          MaterialButton(onPressed: ()=>Navigator.pop(context),child: Text("Отмена"),),
          MaterialButton(onPressed: (){
            Navigator.pop(context);
            context.read<HomeDevices>().addToUserDevices(device,context);
          },child: Text("Да"),)
        ],
      ),
    ));
  }

  void deviceInfo(BuildContext context){
    showDialog(context: context, builder: (context)=>BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
      child: CupertinoAlertDialog(
        content: SizedBox(height: 100,child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(device.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text(device.description,style: TextStyle(fontSize: 13),),
          ],
        ))),
        actions: [
          CupertinoButton(child: Text("Назад"),onPressed: ()=>Navigator.pop(context))
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        deviceInfo(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 15, bottom: 5),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
            //картинка
            Image.asset(
              device.imagePath,
              color: Colors.black,
              height: 70,
            ),

            //имя
            Text(device.name),

            //добавить в устройства
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: 70,
                  decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(12)),
                  child: IconButton(onPressed: () {
                    addToUserDevices(context);
                  }, icon: const Icon(Icons.add))),
            )
          ],
        ),
      ),
    );
  }
}
