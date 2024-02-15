import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_ui/util/my_button.dart';

import '../models/home_devices.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_max,size: 80,color: Colors.grey[800]),
            const SizedBox(height: 20,),
            const Text('Ваш домик',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 40),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.shade800
                      )
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Введите ваше имя',
                ),
              ),
            ),
            MyButton(onTap: (){
              String userName = _nameController.text;
              context
                  .read<HomeDevices>()
                  .addUserName(userName);
              Navigator.pushNamed(context, '/home_page');
            }, child: const Icon(Icons.arrow_forward))
          ],
        ),
      ),
    );
  }
}
