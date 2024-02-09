import 'package:flutter/material.dart';

class DraggableBottomSheet extends StatelessWidget {
  final DraggableScrollableController controller;
  final GlobalKey bottomSheetKey;

  const DraggableBottomSheet({
    super.key,
    required this.bottomSheetKey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          key: bottomSheetKey,
          initialChildSize: 0,
          maxChildSize: 1,
          minChildSize: 0,
          expand: true,
          snap: true,
          snapSizes: [
            60 / constraints.maxHeight,
            0.5,
          ],
          controller: controller,
          builder: (BuildContext context, ScrollController scrollController) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  const SliverToBoxAdapter(
                    child: Text('Title'),
                  ),
                  SliverList.list(
                    children: const [
                      Text('Content'),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
