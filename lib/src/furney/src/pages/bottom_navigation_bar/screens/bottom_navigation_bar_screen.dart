part of '../bottom_navigation_bar_page.dart';

class FurneyBottomNavigationBarScreen extends StatefulWidget {
  final int initialIndex;

  const FurneyBottomNavigationBarScreen({Key? key, this.initialIndex = 0})
      : super(key: key);

  @override
  FurneyBottomNavigationBarScreenState createState() =>
      FurneyBottomNavigationBarScreenState();
}

class FurneyBottomNavigationBarScreenState
    extends State<FurneyBottomNavigationBarScreen> {
  static int selectedIndex = 0;
  late PageController _controller;
  DateTime? _currentBackPressTime;

  @override
  void initState() {
    log('selectedIndexselectedIndex::$selectedIndex');
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
    refreshTabController();
  }

  void refreshTabController() {
    setState(() => selectedIndex = widget.initialIndex);
  }

  Future<bool> _willPopCallback(BuildContext context) async {
    final theme = Theme.of(context);
    final now = DateTime.now();
    log('selectedIndexxxx::$selectedIndex');
    if (selectedIndex != 0) {
      if (_currentBackPressTime == null ||
          now.difference(_currentBackPressTime!) > const Duration(seconds: 1)) {
        _currentBackPressTime = now;
        await Get.offAllNamed<dynamic>(FurneyRoutes.home);

        //   await showToast(msg: AppLocalizations.of(context)!.press_again_to_exit);
        return Future.value(true);
      } else {
        log('hii');
      }
    } else if (selectedIndex == 0) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          contentPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // title: Text("Are you sure?"),
          // content: Text("Do you want to exit?"),
          content: SizedBox(
            width: Screens.width(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: theme.primaryColor,
                    width: Screens.width(context),
                    height: Screens.heigth(context) * 0.06,
                    child: const Text(
                      'Alert',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 40),
                    width: Screens.width(context) * 0.85,
                    child: const Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Are you sure',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Do you want to exit?',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 40),
                    width: Screens.width(context) * 0.85,
                    child: const Divider(color: Colors.grey),
                  ),
                  SizedBox(
                    height: Screens.heigth(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Screens.width(context) * 0.47,
                        height: Screens.heigth(context) * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            textStyle: const TextStyle(color: Colors.white),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {
                            exit(0);
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.47,
                        height: Screens.heigth(context) * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            textStyle: const TextStyle(color: Colors.white),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).pop(false);
                            });
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop) {
        if (didpop) return;
        log('bbbbbbbb');
        _willPopCallback(context);
      },
      child: Scaffold(
        body: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (v) => setState(() => selectedIndex = v),
          children: BottomNavigationList.pageList(context),
        ),
        bottomNavigationBar: ConvexAppBar(
          onTap: (v) {
            setState(() {
              _controller.animateToPage(
                v,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
              );
            });
          },
          backgroundColor: theme.primaryColor,
          activeColor: theme.cardColor,
          curve: Curves.easeInCirc,
          initialActiveIndex: selectedIndex,
          items: [
            TabItem<dynamic>(
              icon: FeatherIcons.home,
              title: AppLocalizations.of(context)!.home,
            ),
            const TabItem<dynamic>(
              icon: FeatherIcons.package,
              title: 'Schemes', //AppLocalizations.of(context)!.discover,
            ),
            const TabItem<dynamic>(
              icon: FeatherIcons.list,
              title: 'Notifications', //AppLocalizations.of(context)!.cart,
            ),
            const TabItem<dynamic>(
              icon: FeatherIcons.user,
              title: 'Profile', //AppLocalizations.of(context)!.search,
            ),
            // TabItem<dynamic>(
            //   icon: FeatherIcons.user,
            //   title: AppLocalizations.of(context)!.profile,
            // ),
          ],
        ),
      ),
    );
  }
}
