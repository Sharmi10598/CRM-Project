import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';


class CustomElevatedButton extends StatelessWidget {
  final String? label;
  final void Function()? onTap;
  final double height;
  final double width;
  final double labelSize;
  final Color? color;
  final Color labelColor;
  final Widget? child;

  const CustomElevatedButton({
    required this.onTap, Key? key,
    this.label,
    this.width = double.infinity,
    this.height = 45.0,
    this.labelSize = 14.0,
    this.color,
    this.labelColor = Colors.white,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Const.radius),
          ),
        ),
        child: (label != null)
            ? AutoSizeText(
                label!,
                maxLines: 1,
                style: theme.textTheme.labelLarge!.copyWith(
                  color: labelColor,
                  fontSize: labelSize,
                ),
              )
            : child,
      ),
    );
  }
}
