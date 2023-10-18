import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool toggle = true;
  Location location = Location();
  LocationData? currentLocation;
  StreamSubscription<LocationData>? _locationSubscription;
  // final loc.Location location = loc.Location();
  // StreamSubscription<loc.LocationData>? _locationSubscription;

  // Future<void> turnOn() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.requestPermission();

  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the 
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }

  //   Position position = await Geolocator.getCurrentPosition();
  //   print(position.latitude);
  //   print(position.longitude);

  //   setState(() {
  //     toggle = true;
  //   });
  // }


  // location.onLocationChanged.listen(
  //   (newloc){
  //     currentLocation = newloc
  //   }
  // );
  
  void locationFirstVid() {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((LocationData currentlocation) async {
      print(currentlocation.latitude);
      // await FirebaseFirestore.instance.collection('location').doc('user1').set({
      //   'latitude': currentlocation.latitude,
      //   'longitude': currentlocation.longitude,
      //   'name': 'john'
      // }, SetOptions(merge: true));
    });
  }

  void locationSecondVid() {
    location.onLocationChanged.listen(
      (newloc){
        currentLocation = newloc;
        print(currentLocation);
        setState(() {});
      }
    );
  }

  void turnOn() {
    setState(() {
      toggle = false;
    });
  }

  void turnOff() {
    setState(() {
      toggle = false;
    });
  }


  // Future<void> _listenLocation() async {
  //   _locationSubscription = location.onLocationChanged.handleError((onError) {
  //     print(onError);
  //     _locationSubscription?.cancel();
  //     setState(() {
  //       _locationSubscription = null;
  //     });
  //   }).listen((loc.LocationData currentlocation) async {
  //     print(currentlocation.latitude);
  //     // await FirebaseFirestore.instance.collection('location').doc('user1').set({
  //     //   'latitude': currentlocation.latitude,
  //     //   'longitude': currentlocation.longitude,
  //     //   'name': 'john'
  //     // }, SetOptions(merge: true));
  //   });
  // }

  // _stopListening() {
  //   _locationSubscription?.cancel();
  //   setState(() {
  //     _locationSubscription = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleOn = ElevatedButton.styleFrom(backgroundColor: Colors.blue);
    final ButtonStyle styleOff = ElevatedButton.styleFrom();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () {locationFirstVid();}, style: (toggle ? styleOn : styleOff), child: const Text('First')),
            ElevatedButton(onPressed: () {locationSecondVid();}, style: (toggle ? styleOn : styleOff), child: const Text('second')),
            ElevatedButton(onPressed: () {turnOff();}, style: (toggle ? styleOff : styleOn), child: const Text('Off')),
          ],
        ),
      ),
    );
  }
}
