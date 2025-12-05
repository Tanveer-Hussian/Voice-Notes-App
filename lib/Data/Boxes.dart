import 'package:hive/hive.dart';
import 'package:voice_notes_app/Data/NotesModel.dart';

class Boxes {
   static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
 }
