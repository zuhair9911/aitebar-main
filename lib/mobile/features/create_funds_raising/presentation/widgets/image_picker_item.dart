import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ImagePickerItem extends StatelessWidget {
  final VoidCallback? onTap;

  const ImagePickerItem({this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: context.primary.withOpacity(0.2),
        child: const SizedBox(
          width: 100,
          height: 100,
          child: Icon(LineIcons.camera),
        ),
      ),
    );
  }
}
