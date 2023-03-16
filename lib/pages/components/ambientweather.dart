import 'package:flutter/material.dart';
import 'package:environment_sensors/environment_sensors.dart';

class AmbientWeather extends StatelessWidget {
  AmbientWeather(
      {super.key,
      required this.ambientTemp,
      required this.ambientHum,
      required this.ambientPress});
  final bool ambientTemp;
  final bool ambientHum;
  final bool ambientPress;
  final environmentSensors = EnvironmentSensors();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(4.0),
            child: (ambientTemp)
                ? StreamBuilder<double>(
                    stream: environmentSensors.temperature,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text(
                          'Sensor Temp: Not available',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            //color: Color.fromARGB(255, 87, 87, 87),
                          ),
                        );
                      }
                      return Text(
                        'Sensor Temp: ${snapshot.data?.toStringAsFixed(1)} °F',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          //color: Color.fromARGB(255, 87, 87, 87),
                        ),
                      );
                    })
                : const Text('No relative temperature sensor found')),
        Padding(
            padding: const EdgeInsets.all(4.0),
            child: (ambientHum)
                ? StreamBuilder<double>(
                    stream: environmentSensors.humidity,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text(
                          'Sensor Humidity: Not available',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            //color: Color.fromARGB(255, 87, 87, 87),
                          ),
                        );
                      }
                      return Text(
                        'Sensor Humidity: ${snapshot.data?.toStringAsFixed(1)}%',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          //color: Color.fromARGB(255, 87, 87, 87),
                        ),
                      );
                    })
                : const Text('No relative humidity sensor found')),
        Padding(
            padding: const EdgeInsets.all(4.0),
            child: (ambientPress)
                ? StreamBuilder<double>(
                    stream: environmentSensors.pressure,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text(
                          'Sensor Pressure: Not available',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            //color: Color.fromARGB(255, 87, 87, 87),
                          ),
                        );
                      }
                      return Text(
                        'Sensor Pressure: ${snapshot.data?.toStringAsFixed(0)} hPa',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          //color: Color.fromARGB(255, 87, 87, 87),
                        ),
                      );
                    })
                : const Text('No relative pressure sensor found')),
      ],
    );
  }
}
