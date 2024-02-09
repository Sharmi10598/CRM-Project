// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'package:ultimate_bundle/src/furney/src/widgets/custom_elevated_button.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/custom_loading_indicator.dart';

class ResendOTPButton extends StatelessWidget {
  final VoidCallback? onSendTap;
  final bool? isLoading;

  const ResendOTPButton({
    Key? key,
    this.onSendTap,
    this.isLoading,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (isLoading == true)
        ?const CustomLoadingIndicator()
        : 
        // CustomFadeTransition(
        //     duration: const Duration(milliseconds: 400),
        //     child: 
            CustomElevatedButton(
               label: 'Resend OTP',//AppLocalizations.of(context)!.send,
              onTap: onSendTap,
           // ),
          );
  }
}
