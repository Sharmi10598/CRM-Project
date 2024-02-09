// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';

class CustomSpinkitdButton extends StatelessWidget {
  final Widget? child;
  final String? label;
  final String? labelLoading;
  final Color? color;
  final VoidCallback? onTap;
  final bool isLoading;
  final double width;
  final double height;
  final double? labelSize;
  final EdgeInsetsGeometry? margin;

  const CustomSpinkitdButton({
    required this.onTap, Key? key,
    this.label,
    this.labelLoading,
    this.color,
    this.child,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 47,
    this.labelSize,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        onPressed: (isLoading == true) ? () {} : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Const.buttonRadius),
          ),
        ),
        child: (isLoading == true)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SpinKitThreeBounce(
                    size: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(width: Const.space12),
                  Text(
                    labelLoading ?? '',
                    style: theme.textTheme.labelLarge,
                  )
                ],
              )
            : (label == '' || label == null)
                ? child
                : Text(
                    label ?? '',
                    style: TextStyles.whiteTextHead(context),
                  ),
      ),
    );
  }
}
