import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_notes_app/Authentication/LoginPage.dart';
import 'package:voice_notes_app/Controllers/NotesController.dart';
import 'package:voice_notes_app/Data/NotesModel.dart';
import 'package:voice_notes_app/Views/HomePage.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   
   final prefs = await SharedPreferences.getInstance();
   bool isLoggedIn = prefs.getBool('isLoggedIn')??false;

   var directory = await getApplicationDocumentsDirectory();
   Hive.init(directory.path);
   Hive.registerAdapter(NotesModelAdapter());
   await Hive.openBox<NotesModel>('notes');

   Get.put(NotesController());

  runApp(MyApp(isLoggedIn: isLoggedIn,));
}


class MyApp extends StatelessWidget {
   final bool isLoggedIn;
   MyApp({super.key, required this.isLoggedIn});
  
  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      title: 'Voice Notes App',
      home: isLoggedIn ? HomePage() : LoginPage(),
    );
  }
}
