import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/core/constants/date_extensions.dart';
import 'package:solar_energy_prediction/core/extensions/string_extensions.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather.dart';

class WeatherForecastHorizontalListView extends StatelessWidget {
  final List<Weather> weatherForecastList;

  const WeatherForecastHorizontalListView(
      {super.key, required this.weatherForecastList});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                S.of(context).weather_5_days_forecast_title,
                style: textTheme.titleSmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weatherForecastList.length,
            itemBuilder: (_, index) {
              final item = weatherForecastList[index];

              return SizedBox(
                width: 90,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          item.timestamp.getDayName().substring(0, 3),
                          style: textTheme.bodyMedium,
                        ),
                        Text(
                          item.timestamp.getTime(),
                          style: textTheme.bodySmall,
                        ),
                        Image.network(item.iconUrl),
                        Text(
                          item.temperature.average
                              .toString()
                              .addCelsiusSymbol(),
                          style: textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
