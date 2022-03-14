import 'package:boeoeg_app/MyHomePage.dart';
import 'package:boeoeg_app/classes/constants.dart';
import 'package:boeoeg_app/classes/httpHelper.dart';
import 'package:boeoeg_app/widgets/selectedCalendarItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

//void main() => runApp(MyApp());

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  HttpHelper httpHelper = HttpHelper();
  String? name = await Hive.box("settings").get("name");

  //! ändern
  // if (name == null) {
  //  name = "1 2";
  // }
  //! testen
  var vorname = name?.split(" ")[0];
  var nachname = name?.split(" ")[1];

  if (name != null) {
    int crrId = await httpHelper
        .loadMitliedIdByName(Constants.getMitliedById + "$vorname,$nachname");
    await Hive.box("settings").put("id", crrId);
    print("crrPerson = $crrId ");
  } else {
    await Hive.box("settings").put("id", 0);
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  static const String _title = 'Böög App';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness? _brightness;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _brightness = WidgetsBinding.instance?.window.platformBrightness;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        _brightness = WidgetsBinding.instance?.window.platformBrightness;
      });
    }

    super.didChangePlatformBrightness();
  }

  CupertinoThemeData get _lightTheme => const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.black,
        textTheme: CupertinoTextThemeData(primaryColor: CupertinoColors.black),
      );

  CupertinoThemeData get _darkTheme => const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.white,
        textTheme: CupertinoTextThemeData(primaryColor: CupertinoColors.white),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: MyApp._title,
      theme: _brightness == Brightness.dark ? _darkTheme : _lightTheme,
      home: const MyHomePage(),
      //home: Hive.box("settings").get("regist") == null          ? Center(              child: Text("Bitte Registrieren"),            )          : MyHomePage(),

      routes: {
        //'/': (context) => const FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        SelectedCalendarItem.routeName: (context) =>
            const SelectedCalendarItem(),
      },
    );
  }
}
