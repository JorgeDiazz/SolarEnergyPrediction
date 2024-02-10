import 'package:flutter/material.dart';
import 'package:solar_energy_prediction/core/config/l10n/l10n.dart';
import 'package:solar_energy_prediction/features/map/domain/entities/map_location.dart';

class SolarIrradiationBottomSheet extends StatelessWidget {
  final DraggableScrollableController controller;
  final GlobalKey bottomSheetKey;
  final MapLocationData? mapLocationData;

  const SolarIrradiationBottomSheet({
    super.key,
    required this.bottomSheetKey,
    required this.controller,
    required this.mapLocationData,
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
            100 / constraints.maxHeight,
            0.5,
          ],
          controller: controller,
          builder: (_, scrollController) {
            return _SolarIrradiationBottomSheetContent(
              scrollController: scrollController,
              mapLocationData: mapLocationData,
            );
          },
        );
      },
    );
  }
}

class _SolarIrradiationBottomSheetContent extends StatelessWidget {
  final ScrollController scrollController;
  final MapLocationData? mapLocationData;

  const _SolarIrradiationBottomSheetContent({
    required this.scrollController,
    required this.mapLocationData,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
            SliverToBoxAdapter(
              child: Text(
                S.of(context).location_selected_title,
                style: textTheme.titleMedium,
              ),
            ),
            SliverList.list(
              children: [
                Row(
                  children: [
                    Text(
                      '(${mapLocationData?.latLng.latitude}, ${mapLocationData?.latLng.longitude})',
                      style: textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
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
}
