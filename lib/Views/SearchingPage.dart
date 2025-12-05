import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voice_notes_app/Controllers/SearchController.dart';
import 'package:voice_notes_app/Data/Boxes.dart';
import 'package:voice_notes_app/Views/NoteDetailPage.dart';

class SearchPage extends StatelessWidget{

    final titleController = TextEditingController();
    final searchController = Get.put(SearchingController());

  @override
  Widget build(BuildContext context) {

      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;
      
    return WillPopScope(
      onWillPop: ()async{
         titleController.clear();
         searchController.filteredNotesList.clear();
         return true; 
       },    
      child: Scaffold(    
        
        appBar: AppBar(
          title: Text(
            'Search Notes',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[500],
         ),
      
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: width,
                  height: height*0.065,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color:Theme.of(context).cardColor,
                      border: Border.all(color:Theme.of(context).dividerColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                   ),
                  child: TextFormField(
                     controller: titleController,
                     decoration: InputDecoration(
                        hintText: 'Search Notes',
                        prefixIcon: Icon(Icons.search, color:Colors.blueGrey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical:12),
                      ),
                     onChanged: (value){
                        final notes = Boxes.getData().values.toList();
                        searchController.filteredNotesList.assignAll(
                           notes.where((note)=> 
                             note.title.toLowerCase().contains(value.toLowerCase())).toList(),
                         );
                       },
                    ),
                 ),
      
               SizedBox(height:height*0.015),
      
               Expanded(
                 child: Obx((){
                    final filteredNotes = searchController.filteredNotesList;
                    if(filteredNotes.isEmpty){
                      return Center(
                        child: Text('No matching notes found!', style:GoogleFonts.poppins(fontSize:16, color:Colors.blueGrey[300]),),
                      );
                     }
                    return ListView.builder(
                      itemCount: filteredNotes.length,
                      itemBuilder: (context,index){
                         final note = filteredNotes[index];
                         return GestureDetector(
                           onTap: (){Get.to(NoteDetailPage(note:note));},
                           child: Card(
                             margin: EdgeInsets.symmetric(vertical:6),
                             shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                             elevation: 3,
                             child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal:16, vertical:8),
                                title: Text(note.title, style: GoogleFonts.poppins(fontSize:16, fontWeight:FontWeight.w600)),
                                trailing: Text(
                                  '${note.timeStamp.day}-${note.timeStamp.month}-${note.timeStamp.year}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: Colors.blueGrey[400]),
                                ),
                             ),
                           ),
                         );
                      }
                    );
                 }),
               ),
      
            ],
          ),
        ),
      ),
    );
  }
}