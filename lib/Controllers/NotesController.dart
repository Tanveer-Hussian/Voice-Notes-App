import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:voice_notes_app/Data/NotesModel.dart';

class NotesController extends GetxController{

    final box = Hive.box<NotesModel>('notes');

    List<NotesModel> get notes => box.values.toList();

    void addNote(String text, String title, DateTime timeStamp){
       box.add(NotesModel(text: text, title: title, timeStamp: timeStamp));
     }

    void deleteNote(int index){
       box.deleteAt(index);
     }

    void editNote(dynamic key, String title, String text, DateTime timeStamp){
       box.put(key, NotesModel(text: text, title: title, timeStamp: timeStamp));
     }

     

}
