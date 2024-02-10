import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/core/extensions/string_extensions.dart';
import 'package:solar_energy_prediction/core/widgets/shared/bordered_list_tile.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_forecast.dart';
import 'package:solar_energy_prediction/features/map/presentation/widgets/weather_forecast_horizontal_list_view.dart';

class WeatherDataBottomSheet extends StatelessWidget {
  final DraggableScrollableController controller;
  final GlobalKey bottomSheetKey;
  final WeatherData? mapLocationData;
  final WeatherForecast? weatherForecast;

  const WeatherDataBottomSheet({
    super.key,
    required this.bottomSheetKey,
    required this.controller,
    required this.mapLocationData,
    required this.weatherForecast,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return DraggableScrollableSheet(
          key: bottomSheetKey,
          initialChildSize: 0,
          maxChildSize: 0.5,
          minChildSize: 0,
          expand: true,
          snap: true,
          snapSizes: [
            140 / constraints.maxHeight,
            0.5,
          ],
          controller: controller,
          builder: (_, scrollController) {
            return _SolarIrradiationBottomSheetContent(
              scrollController: scrollController,
              mapLocationData: mapLocationData,
              weatherForecast: weatherForecast,
            );
          },
        );
      },
    );
  }
}

class _SolarIrradiationBottomSheetContent extends StatelessWidget {
  final ScrollController scrollController;
  final WeatherData? mapLocationData;
  final WeatherForecast? weatherForecast;

  const _SolarIrradiationBottomSheetContent({
    required this.scrollController,
    required this.mapLocationData,
    required this.weatherForecast,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          _buildHorizontalSliverLine(),
          mapLocationData == null || weatherForecast == null
              ? _buildLoadingIndicator()
              : _buildBodyListContent(context),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHorizontalSliverLine() => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 5,
              width: 70,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    15,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  SliverToBoxAdapter _buildLoadingIndicator() => const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  SliverList _buildBodyListContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final country = mapLocationData?.mapLocation.country ?? '';
    final city = mapLocationData?.mapLocation.city ?? '';
    final averageTemperature =
        mapLocationData?.weather.temperature.average ?? 0;
    final maxTemperature = mapLocationData?.weather.temperature.max ?? 0;
    final minTemperature = mapLocationData?.weather.temperature.min ?? 0;
    final weatherDescription = mapLocationData?.weather.description ?? '';
    final latitude = mapLocationData?.mapLocation.coordinates.latitude ?? 0;
    final longitude = mapLocationData?.mapLocation.coordinates.longitude ?? 0;
    final weatherIconUrl = mapLocationData?.weather.iconUrl ?? '';

    return SliverList.list(
      children: [
        Column(
          children: [
            if (country.isNotEmpty && city.isNotEmpty)
              Text(
                '$country, $city',
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            Text(
              averageTemperature.toString().addCelsiusSymbol(),
              style: textTheme.titleLarge?.copyWith(fontSize: 35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.network(weatherIconUrl, width: 40),
                ),
                const SizedBox(width: 5),
                Text(
                  weatherDescription,
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTemperatureRow(context,
                    S.of(context).max_temperature_subtitle, maxTemperature),
                const SizedBox(width: 15),
                _buildTemperatureRow(context,
                    S.of(context).min_temperature_subtitle, minTemperature),
              ],
            ),
            _buildWeatherForecastList(context),
            const SizedBox(height: 15),
            BorderedListTile(
              text: Center(
                child: _buildCoordinatesRow(context, latitude, longitude),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildTemperatureRow(
      BuildContext context, String subtitle, double temperature) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          subtitle,
          style: textTheme.titleMedium,
        ),
        const SizedBox(width: 5),
        Text(
          temperature.toString().addCelsiusSymbol(),
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }

  Row _buildCoordinatesRow(
      BuildContext context, double latitude, double longitude) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on_outlined, size: 20),
        const SizedBox(width: 10),
        Text(
          '($latitude, $longitude)',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }

  WeatherForecastHorizontalListView _buildWeatherForecastList(
      BuildContext context) {
    final weatherForecastList = weatherForecast?.weatherList ?? [];

    return WeatherForecastHorizontalListView(
        weatherForecastList: weatherForecastList);
  }
}
