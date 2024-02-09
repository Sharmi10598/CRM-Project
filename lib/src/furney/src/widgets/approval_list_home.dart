import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class ApprovalCard extends StatelessWidget {
  const ApprovalCard({required this.approvals, Key? key}) : super(key: key);
 final ApprovalsValue ?approvals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding:const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: (){
           // print("object");
        },
        // => Get.toNamed<dynamic>(FurneyRoutes.product, arguments: product),
            borderRadius: BorderRadius.circular(Const.radius),
        child: Container(
          width: Screens.width(context),
          height: Screens.heigth(context)*0.11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Const.radius),
            color: theme.cardColor,
          ),
          padding:const EdgeInsets.all(15),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: Screens.width(context) / 35),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     SizedBox(
                       width: Screens.width(context)*0.7,
                      // color: Colors.redAccent,
                       child: Text(
                          '${approvals!.ObjType}',
                          style: theme.textTheme.headlineMedium!.copyWith(height: 1.2),
                          // textAlign: TextAlign.left,
                          // maxLines: 1,
                        ),
                     ),
                      AutoSizeText(
                         'from',
                        maxLines: 1,
                        style:
                            theme.textTheme.titleSmall!.copyWith(fontSize: 10),
                      ),
                     const Spacer(),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: Screens.width(context) / 20.0,
                  backgroundColor: theme.primaryColor,
                  child: IconButton(
                    icon:const Icon(FeatherIcons.arrowRight),//arrowRightCircle
                    iconSize: Screens.width(context) / 18.0,
                    color: Colors.white,
                    onPressed: () {
                         //showbottomsheet(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}