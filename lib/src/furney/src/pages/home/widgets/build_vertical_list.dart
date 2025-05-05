// ignore_for_file: prefer_single_quotes

part of '../home_page.dart';

class _BuildVerticalList extends StatelessWidget {
  final List<ApprovalsValue> aproval;

  const _BuildVerticalList({required this.aproval, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("aprovals: ${aproval.length}");
    var length = 0;
    if (aproval.length == 1) {
      length = 1;
    } else if (aproval.length == 2) {
      length = 2;
    } else if (aproval.length == 3) {
      length = 3;
    } else if (aproval.length == 4) {
      length = 4;
    } else if (aproval.length == 5) {
      length = 5;
    } else if (aproval.length >= 5) {
      length = 5;
    }
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: length,
      padding: const EdgeInsets.symmetric(horizontal: Const.margin),
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, i) {
        if (aproval.length > 3) {
          return Card(
            elevation: 8,
            child: InkWell(
              onTap: () {
                //   backBtnreload = false;
                // print(i);
                // print(aproval[i].ObjType);
                ApprovalsInfoState.isCameFormHome = true;
                ApprovalsInfoState.iscomeFromRejectORApproved = false;

                ApprovalsDetailsAPi.draftEntry =
                    aproval[i].DraftEntry.toString();
                ApprovalsPatchAPi.approvalID = aproval[i].WddCode.toString();
                ApprovalsInfoState.docTypeName = aproval[i]
                        .ObjType
                        .toString()
                        .contains('13')
                    ? 'A/R Invoice'
                    : aproval[i].ObjType.toString().contains('23')
                        ? 'Sales Quotation'
                        : aproval[i].ObjType.toString().contains('17')
                            ? 'Sales Order'
                            : aproval[i].ObjType.toString().contains('14')
                                ? 'Sales Return'
                                : aproval[i].ObjType.toString().contains('15')
                                    ? 'Deliveries'
                                    : '';
                Get.toNamed<dynamic>(FurneyRoutes.approvalsInfo);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: Screens.heigth(context) * 0.01,
                  bottom: Screens.heigth(context) * 0.01,
                  left: Screens.width(context) * 0.02,
                  right: Screens.width(context) * 0.02,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.7,
                          //color: Colors.red,
                          child: Text(
                            aproval[i].ObjType.toString().contains('13')
                                ? 'A/R Invoice'
                                : aproval[i].ObjType.toString().contains('23')
                                    ? 'Sales Quotation'
                                    : aproval[i]
                                            .ObjType
                                            .toString()
                                            .contains('17')
                                        ? 'Sales Order'
                                        : aproval[i]
                                                .ObjType
                                                .toString()
                                                .contains('14')
                                            ? 'Sales Return'
                                            : aproval[i]
                                                    .ObjType
                                                    .toString()
                                                    .contains('15')
                                                ? 'Deliveries'
                                                : '',
                            //"Request for "+filtervalue![i].ObjType .toString(),
                            style: TextStyles.boldPC1(context),
                          ),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.7,
                          // color: Colors.red,
                          child: Text(
                            "From: ${aproval[i].FromUser}",
                            style: TextStyles.bodytextBlack1(context),
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: Screens.width(context) / 20.0,
                      backgroundColor: theme.primaryColor,
                      child: IconButton(
                        icon: const Icon(
                            FeatherIcons.arrowRight,), //arrowRightCircle
                        iconSize: Screens.width(context) / 18.0,
                        color: Colors.white,
                        onPressed: () {
                          ApprovalsInfoState.isCameFormHome = true;
                          ApprovalsDetailsAPi.draftEntry =
                              aproval[i].DraftEntry.toString();
                          ApprovalsPatchAPi.approvalID =
                              aproval[i].WddCode.toString();
                          ApprovalsInfoState.docTypeName = aproval[i]
                                  .ObjType
                                  .toString()
                                  .contains('13')
                              ? 'A/R Invoice'
                              : aproval[i].ObjType.toString().contains('23')
                                  ? 'Sales Quotation'
                                  : aproval[i].ObjType.toString().contains('17')
                                      ? 'Sales Order'
                                      : aproval[i]
                                              .ObjType
                                              .toString()
                                              .contains('14')
                                          ? 'Sales Return'
                                          : aproval[i]
                                                  .ObjType
                                                  .toString()
                                                  .contains('15')
                                              ? 'Deliveries'
                                              : '';
                          Get.toNamed<dynamic>(FurneyRoutes.approvalsInfo);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
