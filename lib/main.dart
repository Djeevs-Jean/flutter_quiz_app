import 'package:flutter/material.dart';
import 'package:flutter_quiz/screens/activity_page.dart';
import 'package:flutter_quiz/screens/quizzes_page.dart';
import 'package:flutter_quiz/screens/about_page.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('en', 'HT')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'HT'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Code Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Tab> tabs = [
    Tab(text: 'labelquiz'.tr().toString()), Tab(text: 'labelactivity'.tr().toString())
  ];
   @override
  Widget build(BuildContext context) {
    String titleAppbar = 'apptitle'.tr();
    // context.locale = Locale('en', 'HT');

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(titleAppbar, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          
          // title: const Text('Quiz App'),
          bottom: TabBar(tabs: tabs, labelStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        ),
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(titleAppbar),
              accountEmail: Text('mastercodequiz@dev.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/icon_master.png'),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              
              ListTile(
                leading: const Icon(Icons.language),
                title: Text('chooselanguage'.tr()),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LanguageSelectionDialog();
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('about'.tr()),
                
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(  children: [QuizzesTab(), ActivityTab()
        //, IndexTab(),
         ], ),
      ),
    );
  }
}
class LanguageSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('label'.tr()),
      children: [
        RadioListTile(
          title: const Text('Kreyol'),
          value: 'HT',
          groupValue: context.locale.countryCode, // Utilise le code de pays de la langue actuelle comme valeur de groupe
          onChanged: (value) {
            // Met à jour la langue vers le créole haïtien
            context.setLocale(Locale('en', 'HT'));
            Navigator.of(context).pop(); // Ferme le dialogue
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false,
            ); // Navigue vers MainScreen et ferme les autres routes
          },
        ),
        RadioListTile(
          title: const Text('English'),
          value: 'US',
          groupValue: context.locale.countryCode, // Utilise le code de pays de la langue actuelle comme valeur de groupe
          onChanged: (value) {
            // Met à jour la langue vers l'anglais
            context.setLocale(Locale('en', 'US'));
            Navigator.of(context).pop(); // Ferme le dialogue
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false,
            ); // Navigue vers MainScreen et ferme les autres routes
          },
        ),
      ],
    );
  }
}