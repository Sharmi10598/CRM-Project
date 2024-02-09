part of '../discover_page.dart';

class Schemes extends StatefulWidget { 
  const Schemes({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  SchemesnState createState() => SchemesnState();
}

class SchemesnState extends State<Schemes> {
  final int _selectedIndex = 0;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: appBar(context, _scaffoldKey, widget.title),
      body: Center(
        child: Text('Schemes',
         style:GoogleFonts.poppins(
                              fontSize: Screens.heigth(context) * 0.018,
                              //color: theme.primaryColor
                              ),
        ),
      ),
    );
  }
}
