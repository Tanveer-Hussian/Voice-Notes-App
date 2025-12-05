import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_notes_app/Authentication/LoginPage.dart';
import 'package:voice_notes_app/Widgets/FieldWidget.dart';

class SignUpPage extends StatelessWidget{

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     final width = MediaQuery.of(context).size.width;
     final height = MediaQuery.of(context).size.height;

    return Scaffold(
     
      appBar: AppBar(title: Text('SignUp', style: TextStyle(fontWeight:FontWeight.bold),), centerTitle: true, backgroundColor:Colors.blueGrey, foregroundColor:Colors.white,),
    
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height:height*0.17),
              FieldWidget(
                controller: nameController,
                keyBoardType: TextInputType.name,
                hintText: 'Enter name', 
                validator: (value){
                  if(value.toString().isEmpty){
                    return 'Name is required';
                  }else{
                    return null;
                  }
                  } 
              ),
              SizedBox(height:height*0.01), 
        
              FieldWidget(
                controller: emailController,
                keyBoardType: TextInputType.emailAddress,
                hintText: 'Enter email', 
                validator: (value){
                  if(value.toString().isEmpty){
                    return 'Email is required';
                  }else{
                    return null;
                  }
                  } 
              ),
              SizedBox(height:height*0.01),
        
              FieldWidget(
                controller: passwordController,
                keyBoardType: TextInputType.visiblePassword,
                hintText: 'Enter password', 
                validator: (value){
                  if(value.toString().isEmpty){
                    return 'Password is required';
                  }else{
                    return null;
                  }
                  } 
              ),
          
              SizedBox(height:height*0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Text('Already have an account'),
                    TextButton(onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));}, child:Text('Login',style:TextStyle(fontSize:16,fontWeight:FontWeight.bold, color: Colors.blue),))
                  ],
              ),

              SizedBox(height:height*0.06),        
              GestureDetector(
                  onTap: () async{
                     if(nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty){
                       showDialog(
                         context: context,
                         builder:(context){ 
                            return AlertDialog(
                              content: Text('Fill required fields'),
                            );
                          }
                       );
                     }else{
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('name', nameController.text.toLowerCase());
                        prefs.setString('email', emailController.text);
                        prefs.setString('password', passwordController.text);
                       // ignore: use_build_context_synchronously
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                     }
                   },
                  child: Container(
                    width: width*0.39,
                    height: height*0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue
                    ),
                    child: Center(child: Text('Create Account', style:TextStyle(color: Colors.white, fontSize:16, fontWeight:FontWeight.bold),),),
                  ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
} 