import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_notes_app/Authentication/LoginPage.dart';
import 'package:voice_notes_app/Controllers/NotesController.dart';
import 'package:voice_notes_app/Data/Boxes.dart';
import 'package:voice_notes_app/Data/NotesModel.dart';
import 'package:voice_notes_app/Views/AddNotePage.dart';
import 'package:voice_notes_app/Views/NoteDetailPage.dart';
import 'package:voice_notes_app/Views/SearchingPage.dart';

class HomePage extends StatelessWidget{
  
   final notesController = Get.find<NotesController>();
   final edittedTitle = TextEditingController();
   final edittedText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;

    return Scaffold(

      appBar: AppBar(
         title: Text('Voice Notes App',style:GoogleFonts.poppins(color:Colors.white),), 
         centerTitle: true, 
         backgroundColor: Colors.blueGrey[500],
         automaticallyImplyLeading: false,
         actions: [
           IconButton(
             onPressed: ()async{
               final prefs = await SharedPreferences.getInstance();
               prefs.setBool('isLoggedIn', false);
               Get.to(LoginPage());
             }, 
             icon: Icon(Icons.logout, color: Colors.red[800],)
            )
          ],
        ),

       body: notesController.notes.isEmpty
          ?   
         Center(
           child: Text('No Note added yet!', style:GoogleFonts.poppins(fontSize:16,fontWeight:FontWeight.bold,color:Colors.blueGrey[400]),),
         )
          : 
      Column(
        children: [

           SizedBox(height:height*0.01),
           GestureDetector(
             onTap: (){Get.to(SearchPage());},
             child: Container(
                width: width*0.8,
                height: height*0.065,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color:Theme.of(context).cardColor,
                  border: Border.all(color:Theme.of(context).dividerColor),
                   boxShadow: [                                     // ⭐ ADDED
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                 ),
                child: Row(
                  children: [
                    SizedBox(width:10),
                    Icon(Icons.search, color: Theme.of(context).hintColor), 
                    SizedBox(width:10),
                    Text(
                      "Search Notes",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Theme.of(context).hintColor,        
                      ),
                    ),
                  ],
                ),
              ),
            ),
           
           SizedBox(height:height*0.01),
           
           ValueListenableBuilder<Box<NotesModel>>(
              valueListenable: Boxes.getData().listenable(),
              builder: (context,box,_){
                 var data = box.values.toList().cast<NotesModel>();
                 data = data.reversed.toList();

                return ListView.builder(
                  itemCount: box.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    final note = data[index];
                    String formattedTime = DateFormat('dd-MM-yyyy').format(DateTime.parse(note.timeStamp.toString()));
                    return Padding(
                      padding: const EdgeInsets.only(top:5, bottom:3, left:12, right:9),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(NoteDetailPage(note:note,));
                        },
                        child: SlideableWidget(note, index, width, height, formattedTime, context),
                      ),
                    ); 
                  }
               );
             }         
           ),
        
         ], 
       ),

       floatingActionButton: FloatingActionButton(
         backgroundColor: Theme.of(context).colorScheme.primary,
         onPressed: (){
            Get.to(AddNotePage()); 
          },
         shape: CircleBorder(),
         child: Icon(Icons.add, size:30,color: Colors.white,),
       ),

    );
  }

 
  Widget SlideableWidget(NotesModel note, int index, double width, double height, String formattedTime, BuildContext context) {
     return Slidable(
              key: ValueKey(note.key),
              endActionPane: ActionPane(
                  motion:const DrawerMotion(), 
                  children:[

                    SlidableAction(
                      icon: Icons.edit,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      label: 'Edit',
                      onPressed: (context){
                          edittedTitle.text = note.title;
                          edittedText.text = note.text;

                          Get.bottomSheet(
                            Container( 
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.vertical(top:Radius.circular(20))
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                
                                      Text('Edit Note', style:GoogleFonts.poppins(fontSize:18, fontWeight:FontWeight.bold),),
                                      SizedBox(height:12),
                                
                                      TextFormField(
                                        controller: edittedTitle,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(5)),
                                          hintText:'Enter Title'
                                        ),
                                        ),
                                        SizedBox(height:8),
                                
                                      TextFormField(
                                        controller: edittedText,
                                        maxLines: 6,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(5)),
                                          hintText:'Enter Text'
                                        ),  
                                        ),
                                        SizedBox(height:20),
                                
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueGrey,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            minimumSize: Size(double.infinity,40)
                                          ),
                                          child: Text("Save"),
                                          onPressed:(){
                                            if(edittedTitle.text.trim().isEmpty|| edittedText.text.trim().isEmpty){
                                              Get.snackbar(
                                                "Invalid Input",
                                                "Both Title & Text are required",
                                                backgroundColor: Colors.redAccent,
                                                colorText: Colors.white,
                                              );
                                              return; 
                                            }
                                            
                                            notesController.editNote(
                                                note.key, edittedTitle.text.trim(),
                                                edittedText.text.trim(), DateTime.now()
                                              );
                                            Get.back();
                                          }, 
                                        ),
                                    ],
                                  ),
                              ),
                              ),
                            isDismissible: true,
                            enableDrag: true,
                          );
                        },                              
                      ),

                    SlidableAction(
                      icon: Icons.delete,
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Colors.white,
                      label: 'Delete',
                      onPressed: (context){
                        Get.dialog(
                          AlertDialog(
                            title: Text('Are you sure?'),
                            actions: [
                                ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey[500],
                                  foregroundColor:Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text('Cancel'),
                                onPressed:(){Get.back();}
                                ),
                                ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor:Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text('Delete'),
                                onPressed:(){
                                    notesController.deleteNote(index);
                                    Get.back();
                                  }
                                ),
                            ],
                          )
                        );
                          
                        }
                    ),
                
                  ],
                ),

              child: Container(
                padding:EdgeInsets.only(left:width*0.05),
                width: width*0.9,
                height: height*0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(                                      
                      color: MediaQuery.of(context).platformBrightness==Brightness.light?Colors.black12:Colors.white24,
                      blurRadius: 4,
                      offset: Offset(0,2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(note.title, style:GoogleFonts.poppins(fontSize:16,fontWeight:FontWeight.bold,color:Theme.of(context).textTheme.bodyLarge!.color,)),
                    SizedBox(height:height*0.01,),
                    Text(formattedTime, style:GoogleFonts.poppins(fontSize:12, color: Theme.of(context).hintColor, ),), 
                  ],
                ),
              ),
    
      );
   }


 }
