// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider_dio/providers/bottomnav_provider.dart';
import 'package:mvvm_provider_dio/services/user_api_service.dart';
import 'package:mvvm_provider_dio/views/bottomnav/map_screen.dart';
import 'package:mvvm_provider_dio/views/bottomnav/product_screen.dart';
import 'package:mvvm_provider_dio/views/bottomnav/user_screen.dart';
import 'package:mvvm_provider_dio/views/home/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:demomodule/demomodule.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Setup push notification
  late FirebaseMessaging messaging;

  void setupNotification(){
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print('FCM Token: $value');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('message recieved');
      print(event.notification!.body);
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(event.notification!.title!),
            content: Text(event.notification!.body!),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                child: Text('Ok')
              )
            ],
          );
        }
      );
    });
  }

  // bottom navigation screen
  var currentTab = [
    UserScreen(),
    ProductScreen(),
    MapScreen(),
  ];

  int _num = 100;

  @override
  void initState() {
    super.initState();
    // Test Call API
    UserApiService().getUser();
    setupNotification();

    // Test Module from another project
    _num = Calculator().addOne(_num);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<BottomNavProvider>(
          builder: (context, provider, child){
            return Text(provider.title);
          },
        ),
        actions: [
          TextButton(
            onPressed: (){}, 
            child: Text(_num.toString(), style: TextStyle(color: Colors.white)))
        ],
      ),
      body: Consumer<BottomNavProvider>(
          builder: (context, provider, child){
          return currentTab[provider.currentIndex];
        },
      ),
      bottomNavigationBar: Consumer<BottomNavProvider>(
        builder: (context, provider, child){
          return BottomNavigationBar(
            currentIndex: provider.currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              provider.updateIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Users'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storefront),
                label: 'Products'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Maps'
              ),
            ]
          );
        },
      ),
    );
  }
}