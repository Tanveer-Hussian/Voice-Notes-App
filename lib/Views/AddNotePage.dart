import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voice_notes_app/Controllers/NotesController.dart';
import 'package:voice_notes_app/Controllers/SpeechController.dart';
import 'package:voice_notes_app/Views/HomePage.dart';

class AddNotePage extends StatelessWidget{

    final controller = Get.put(SpeechController());
    final noteController = Get.find<NotesController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Add Note', style:GoogleFonts.poppins(fontSize:21,fontWeight:FontWeight.bold,color:Colors.blueGrey[700]),), 
        centerTitle: true,
        actions: [
           IconButton(
             onPressed:(){
                String title = generateTitle(controller.wordsSpoken.value);
                String text = controller.wordsSpoken.value;
                noteController.addNote(text,title,DateTime.now());
                controller.wordsSpoken.value='';
               Get.off(HomePage());
             }, 
             icon:Icon(Icons.save, size:26, color:Colors.red[500]),
            ),
           SizedBox(width:10),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(height:20),
                Obx(()=>
                   Text(
                       controller.isListening.value 
                           ? 'listening...' 
                           : (controller.speechEnabled.value ? 'Press on mic to start recording note':'Speech not available'), 
                       style:GoogleFonts.poppins(fontSize:15,color:Colors.blueGrey[700]),),
                  ),
                 
                 SizedBox(height:20),
          
                 Obx((){
                   if(controller.wordsSpoken.value.isNotEmpty){
                      return Text(controller.wordsSpoken.value, style:GoogleFonts.poppins(fontSize:15, fontWeight:FontWeight.w700),);
                   }else{
                      return SizedBox.shrink();
                    }  
                 }),  

                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     TextButton(onPressed:(){controller.wordsSpoken.value='';}, child:Text('Clear'),),
                     SizedBox(width:5,)
                   ],
                 )
                 
                ],
              ),
              
             ], 
            ),
        
       ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom:20),
        child: FloatingActionButton(         
          shape: CircleBorder(),
          elevation:4,
          onPressed: (){controller.isListening.value?controller.stopListening():controller.startListening();},
          child: Obx(()=>CircleAvatar(radius:35,child: Icon(controller.isListening.value? Icons.pause : Icons.mic, color:Colors.red, size:33,))),
         ),
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }


  String generateTitle(String spokenText){
    if(spokenText.isEmpty){
      return 'UnTitled';
    }else{
      List<String> sentences = spokenText.split(RegExp(r'[.!?\n]'));
      String firstSentence = sentences.first.trim();
      if(firstSentence.length>30){
        return firstSentence.substring(0,20)+'...';
      }else{
        return firstSentence;
      } 
    }
  }


}
