part of '../forgot_password_page.dart';

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomShakeTransition(
          child: AutoSizeText(
            'Enter OTP',//AppLocalizations.of(context)!.forgot_password,
            style: theme.textTheme.displayLarge,
            maxLines: 1,
          ),
        ),
         SizedBox(height: Screens.heigth(context)*0.01 ),
        CustomShakeTransition(
          duration: const Duration(milliseconds: 3),
          child: AutoSizeText(
            // ignore: lines_longer_than_80_chars
            // AppLocalizations.of(context)!
            //     .please_Enter_your_eMail_Address_Your_will_Receive_a_link_to_Create_a_new_Password_via_email,
            'Please enter the otp which was sent to your registered mail ID',
            style: theme.textTheme.bodyMedium,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
