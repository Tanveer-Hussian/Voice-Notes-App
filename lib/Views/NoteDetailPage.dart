import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:voice_notes_app/Controllers/NotesController.dart';
import 'package:voice_notes_app/Data/NotesModel.dart';

class NoteDetailPage extends StatelessWidget{

    NotesModel note; 
    NoteDetailPage({required this.note});
   
  @override
  Widget build(BuildContext context) {

      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;
      String formattedDate = DateFormat('dd-MMM-yyyy hh:mm a').format(DateTime.parse(note.timeStamp.toString()));
    
     return Scaffold(
       appBar: AppBar(automaticallyImplyLeading:true, title:Text('View Details'), centerTitle:true),
       body: Padding(
         padding: EdgeInsets.only(top:20,left:15,right:15),
         child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
             children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(note.title, style:GoogleFonts.poppins(fontSize:17, fontWeight:FontWeight.w600)),
                    Icon(Icons.edit_document),
                  ],
                ),
                Text(formattedDate),
                SizedBox(height:height*0.03),

                Row(
                  children: [
                    SizedBox(width:width*0.8),
                    Icon(Icons.edit_document),
                  ],
                 ),
                SizedBox(height:height*0.01),

                Container(
                  width: width*0.9,
                  height: height*0.4,
                  padding: EdgeInsets.all(width*0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight:Radius.circular(10)),
                    border: Border.all(color: MediaQuery.of(context).platformBrightness==Brightness.light?Colors.black26:Colors.white30) 
                  ),
                  child: Text(note.text, style:GoogleFonts.poppins(fontSize:15)),
                ),
             ],
           ),
         ),
      );
  }
}
