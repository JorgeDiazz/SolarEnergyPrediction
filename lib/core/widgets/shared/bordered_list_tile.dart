import 'package:flutter/material.dart';

class BorderedListTile extends StatelessWidget {
  final Widget text;

  const BorderedListTile({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 0),
        ListTile(
          title: text,
        ),
        const Divider(height: 0),
      ],
    );
  }
}
