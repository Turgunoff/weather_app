import 'package:flutter/material.dart';
import 'package:weather_app/helper/extensions.dart';
import 'package:weather_app/helper/utils.dart';
import 'package:weather_app/provider/weatherProvider.dart';
import 'package:weather_app/theme/textStyle.dart';
import 'package:provider/provider.dart';

import 'customShimmer.dart';

class MainWeatherInfo extends StatelessWidget {
  const MainWeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      if (weatherProv.isLoading) {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomShimmer(
                height: 148.0,
                width: 148.0,
              ),
            ),
            SizedBox(width: 16.0),
            CustomShimmer(
              height: 148.0,
              width: 148.0,
            ),
          ],
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            weatherProv.isCelsius
                                ? weatherProv.weather.temp.toStringAsFixed(1)
                                : weatherProv.weather.temp
                                    .toFahrenheit()
                                    .toStringAsFixed(1),
                            style: boldText.copyWith(fontSize: 86),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            weatherProv.measurementUnit,
                            style: mediumText.copyWith(fontSize: 26),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    weatherProv.weather.description.toTitleCase(),
                    style: lightText.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 148.0,
              width: 148.0,
              child: Image.asset(
                getWeatherImage(weatherProv.weather.weatherCategory),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    });
  }
}
