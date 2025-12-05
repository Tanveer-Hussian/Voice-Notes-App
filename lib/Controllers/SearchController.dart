import 'package:get/get.dart';
import 'package:voice_notes_app/Data/NotesModel.dart';

class SearchingController extends GetxController{
   
   RxList<NotesModel> filteredNotesList = <NotesModel>[].obs;

   List<NotesModel> get filteredNotes => filteredNotesList;

 }
