// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';

import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';

class NotifyDialog extends StatefulWidget {
  NotifyDialog({
    required this.title,
    required this.descp,
    required this.imgUrl,
    required this.page,
    Key? key,
  }) : super(key: key);
  String title;
  String descp;
  String imgUrl;
  String page;
  @override
  State<NotifyDialog> createState() => _FollowDialogState();
}

class _FollowDialogState extends State<NotifyDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: notifyDialog(context, theme),
    );
  }

  Container notifyDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Screens.width(context),
            height: Screens.heigth(context) * 0.06,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(),
                  Text('Notification'),
                  Container(),
                ],
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                Container(
                  child: Text(
                    '${widget.title}',
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                SizedBox(
                  height: Screens.heigth(context) * 0.01,
                ),
                Text(
                  '${widget.descp}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                if (widget.imgUrl == 'null')
                  Container()
                else
                  SizedBox(
                    width: Screens.width(context),
                    height: Screens.heigth(context) * 0.2,
                    child: Center(
                      child: Image(
                        image: NetworkImage(
                          '${widget.imgUrl}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                SizedBox(
                  height: Screens.heigth(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.3,
                      height: Screens.heigth(context) * 0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Ok',
                          // style: theme.textTheme.bodyText2?.copyWith(
                          //   color: Colors.white,
                          //   fontSize: 14
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.03,
                    ),
                    if (widget.page.isEmpty ||
                        widget.page.toLowerCase() == 'null')
                      Container()
                    else
                      SizedBox(
                        width: Screens.width(context) * 0.3,
                        height: Screens.heigth(context) * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                          ),
                          onPressed: () {
                            // gotoPages(widget.page,context);
                          },
                          child: Text(
                            '${widget.page}',
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
