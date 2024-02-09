part of '../sign_in_page.dart';

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomShakeTransition(
         child:  AutoSizeText(
            AppLocalizations.of(context)!.proceed_with_your,
            style: theme.textTheme.bodyLarge,
            maxLines: 1,
          ),
        ),
       const SizedBox(height: 5),
        CustomShakeTransition(
          duration:const Duration(seconds: 4),
          child: AutoSizeText(
            AppLocalizations.of(context)!.lets_sign_you_in,
            style: theme.textTheme.displayLarge,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
