import 'package:flutter/material.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';


class CustomOutlinedButton extends StatelessWidget {
  final void Function()? onTap;
  final String? label;
  final double height;
  final double width;
  final double labelSize;
  final Color? color;
  final Color labelColor;

  const CustomOutlinedButton({
    required this.onTap, required this.label, Key? key,
    this.width = double.infinity,
    this.height = 45.0,
    this.labelSize = 14.0,
    this.color ,
    this.labelColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Const.radius),
            side: BorderSide(
              color: theme.primaryColor,
            ),
          ), disabledForegroundColor: Colors.red.withOpacity(0.38),
        ),
        child: Text(
          label!,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: labelSize,
          ),
        ),
      ),
    );
  }
}
