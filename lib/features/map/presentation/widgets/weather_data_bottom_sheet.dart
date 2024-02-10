import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/core/widgets/shared/bordered_list_tile.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/weather_data.dart';

class WeatherDataBottomSheet extends StatelessWidget {
  final DraggableScrollableController controller;
  final GlobalKey bottomSheetKey;
  final WeatherData? weatherData;

  const WeatherDataBottomSheet({
    super.key,
    required this.bottomSheetKey,
    required this.controller,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return DraggableScrollableSheet(
          key: bottomSheetKey,
          initialChildSize: 0,
          maxChildSize: 1,
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
              weatherData: weatherData,
            );
          },
        );
      },
    );
  }
}

class _SolarIrradiationBottomSheetContent extends StatelessWidget {
  final ScrollController scrollController;
  final WeatherData? weatherData;

  const _SolarIrradiationBottomSheetContent({
    required this.scrollController,
    required this.weatherData,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            _buildHorizontalSliverLine(),
            weatherData == null ? _buildLoadingIndicator() : _buildBodyListContent(context),
          ],
        ),
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

    final country = weatherData?.mapLocation.country ?? '';
    final city = weatherData?.mapLocation.city ?? '';
    final averageTemperature = weatherData?.weather.temperature.average ?? 0;
    final maxTemperature = weatherData?.weather.temperature.max ?? 0;
    final minTemperature = weatherData?.weather.temperature.min ?? 0;
    final weatherDescription = weatherData?.weather.description ?? '';
    final latitude = weatherData?.mapLocation.coordinates.latitude ?? 0;
    final longitude = weatherData?.mapLocation.coordinates.longitude ?? 0;
    final weatherIconUrl = weatherData?.weather.iconUrl ?? '';

    return SliverList.list(
      children: [
        Column(
          children: [
            if (country.isNotEmpty && city.isNotEmpty)
              Text(
                '$country, $city',
                style: textTheme.titleLarge,
              ),
            Text(
              '${averageTemperature.toString()}${S.of(context).celsius_symbol}',
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
                Text(
                  weatherDescription,
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
            BorderedListTile(
              text: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTemperatureRow(context, S.of(context).max_temperature_subtitle, maxTemperature),
                  const SizedBox(width: 15),
                  _buildTemperatureRow(context, S.of(context).min_temperature_subtitle, minTemperature),
                ],
              ),
            ),
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

  Row _buildTemperatureRow(BuildContext context, String subtitle, double temperature) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          subtitle,
          style: textTheme.titleMedium,
        ),
        Text(
          '$temperature${S.of(context).celsius_symbol}',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }

  Row _buildCoordinatesRow(BuildContext context, double latitude, double longitude) {
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
}
