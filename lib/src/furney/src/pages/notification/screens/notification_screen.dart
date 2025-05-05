// ignore_for_file: prefer_single_quotes, require_trailing_commas

part of '../notification_page.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DataBaseHelper dbHelper = DataBaseHelper();
  Configuration config = Configuration();
  List<NotificationModel2> notify = [];
  List<NotificationModel2> notifyreverse = [];
  List<NotificationModel2> get getnotify => notify;
//   void deleteNotify(int docid)async{
//   await dbHelper.deleteNotify(docid);

//     notifyreverse = await dbHelper.getNotification();
//  setState(() {
//       notify =  notifyreverse.reversed.toList();
//  });

// }
// void deleteNotifyAll()async{
//   await dbHelper.deleteNotifyAll();

//     notifyreverse = await dbHelper.getNotification();
//   setState(() {
//       notify =  notifyreverse.reversed.toList();
//   });

// }

  Future<void> onReciveFCM() async {
    // log("AAANNNNNN1111111");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // final notify = <NotificationModel>[];
      if (message.notification != null) {
        getNotification();
        getUnSeenNotify();
        //  log("AAANNNNNN");
        //  Provider.of<NotificationContoller>(context,listen: false).getUnSeenNotify();
        // navigatorKey.currentContext!.read<NotificationContoller>().getUnSeenNotify();
      }
    });
  }

  int? unSeenNotify;
  int get getunSeenNotify => unSeenNotify != null ? unSeenNotify! : 0;
  Future<void> getUnSeenNotify() async {
    unSeenNotify = await dbHelper.getUnSeenNotificationCount();
    // setState(() {

    // });
  }

  Future swipeRefreshIndiactor() async {
    notifyreverse = await dbHelper.getNotification();
    setState(() {
      notify = notifyreverse.reversed.toList();
    });
  }

  Future<void> updateSeenTime(int id, String time) async {
    await dbHelper.updateNotify(id, time);

    notifyreverse = await dbHelper.getNotification();
    setState(() {
      notify = notifyreverse.reversed.toList();
    });
  }

  void clearData() {
    notify.clear();
    notifyreverse.clear();
  }

  Future<void> getNotification() async {
    notifyreverse = await dbHelper.getNotification();
    setState(() {
      notify = notifyreverse.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      clearData();
      getNotification();
      // setBadgeNum(2);
      onReciveFCM();
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop) {
        if (didpop) return;
        log("bbbbbbbb");
        onbackpress();
      },
      child: Scaffold(
          // drawer: drawer3(context),
          key: _scaffoldKey,
          appBar: appBar(context, _scaffoldKey, widget.title),
          drawer:
              // GetValues.userRoll == '3' ? drawer2(context) :
              drawer(context),
          body: SafeArea(
              child: SizedBox(
            width: Screens.width(context),
            height: Screens.heigth(context),
            child: (getnotify.isEmpty && getunSeenNotify == 0)
                ? const Center(child: Text('No Notification'))
                : (getnotify.isEmpty && getunSeenNotify > 0)
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          SizedBox(
                            height: Screens.heigth(context) * 0.01,
                          ),
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () {
                                return swipeRefreshIndiactor();
                                setState(() {});
                                // return swipeRefreshIndiactor();
                              },
                              child: ListView.builder(
                                // reverse: true,
                                // shrinkWrap: true,
                                itemCount: getnotify.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: () {
                                        setState(() {});

                                        showDialog<void>(
                                            context: context,
                                            builder: (_) {
                                              final time = config.currentDate();
                                              updateSeenTime(
                                                  getnotify[index].id!, time);
                                              return NotifyDialog(
                                                descp: getnotify[index]
                                                    .description,
                                                title:
                                                    '${getnotify[index].titile}',
                                                imgUrl: getnotify[index].imgUrl,
                                                page: getnotify[index].naviScn,
                                              );
                                            }).then((value) {
                                          getNotification();
                                          setState(() {});
                                        });
                                      },
                                      onLongPress: () {
                                        showDialog<void>(
                                            context: context,
                                            builder: (_) {
                                              return NotifyDeleteDialog(
                                                docid: getnotify[index].id!,
                                              );
                                            }).then((value) {
                                          getNotification();
                                          setState(() {});
                                        });
                                      },
                                      child: DataContainer1(
                                          context, index, theme));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
          )
              //   });
              // }),
              )),
    );
  }

  Container DataContainer1(BuildContext context, int index, ThemeData theme) {
    return Container(
      //  color: Colors.red,
      width: Screens.width(context),
      padding: EdgeInsets.symmetric(
          vertical: Screens.heigth(context) * 0.01,
          horizontal: Screens.width(context) * 0.01),

      margin: EdgeInsets.symmetric(
        vertical: Screens.heigth(context) * 0.005,
      ),

      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: Screens.heigth(context) * 0.01,
            horizontal: Screens.width(context) * 0.02),
        color:
            getnotify[index].seenTime == '0' ? Colors.grey[300] : Colors.white,
        child: Column(children: [
          SizedBox(
            width: Screens.width(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Screens.width(context) * 0.65,
                  // color: Colors.red,
                  child: Text(
                    "${getnotify[index].titile}",
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.25,
                  //    color: Colors.red,
                  child: Text(
                    config.alignDate2(getnotify[index].receiveTime),
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Screens.heigth(context) * 0.02,
          ),
          SizedBox(
            width: Screens.width(context),
            child: Text(
              getnotify[index].description,

              maxLines: 1,
              // linkColor: Colors.blue,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontSize: 12, color: Colors.grey),
            ),
          ),
          if (getnotify[index].imgUrl == 'null')
            Container()
          else
            SizedBox(
              width: Screens.width(context),
              height: Screens.heigth(context) * 0.2,
              child: Center(
                  child: Image(
                      image: NetworkImage(getnotify[index].imgUrl),
                      fit: BoxFit.cover)),
            ),
          SizedBox(
            height: Screens.heigth(context) * 0.02,
          ),
          const Divider(
            thickness: 2,
            endIndent: 0,
            height: 0,
            indent: 0,
          )
        ]),
      ),
    );
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final now = DateTime.now();
    getUnSeenNotify();
    clearData();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }
}
