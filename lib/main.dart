import 'package:flutter/material.dart';
import 'package:light_sensor/light_sensor.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Light sensor example')),
        body: Center(
          child: FutureBuilder<bool>(
            future: LightSensor.hasSensor(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final bool hasSensor = snapshot.data!;
                if (hasSensor) {
                  return StreamBuilder<int>(
                    stream: LightSensor.luxStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text('Running on: ${snapshot.data} LUX');
                      } else {
                        return const Text('Running on: unknown');
                      }
                    },
                  );
                } else {
                  return const Text("Your device doesn't have a light sensor");
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
