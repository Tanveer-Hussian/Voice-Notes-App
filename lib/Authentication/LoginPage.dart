import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_notes_app/Authentication/SignUpPage.dart';
import 'package:voice_notes_app/Views/HomePage.dart';
import 'package:voice_notes_app/Widgets/FieldWidget.dart';

class LoginPage extends StatelessWidget{

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     final width = MediaQuery.of(context).size.width;
     final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Login', style: TextStyle(fontWeight:FontWeight.bold),), centerTitle: true, backgroundColor:Colors.blueGrey, foregroundColor:Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*0.2),
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
                     Text('Donot have an account'),
                     TextButton(onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));}, child:Text('Create Account',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold, color: Colors.blue),))
                   ],
                ),
                SizedBox(height:height*0.07),
          
                 GestureDetector(
                   onTap: () async{
                     if(emailController.text.isEmpty || passwordController.text.isEmpty){                       
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
                          final existingEmail = prefs.getString('email');
                          final existingPassword = prefs.getString('password');
                        if(emailController.text==existingEmail && passwordController.text==existingPassword){
                            prefs.setBool('isLoggedIn', true);
                            Get.offAll(HomePage());
                        }else{                        
                          Get.snackbar('Could not login', 'Credentials didnot math', duration: Duration(milliseconds:700));
                         }
                      }
                    },
                   child: Container(
                     width: width*0.39,
                     height: height*0.06,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: Colors.blue
                     ),
                     child: Center(child: Text('Login', style:TextStyle(color: Colors.white, fontSize:16, fontWeight:FontWeight.bold),),),
                   ),
                 )
            ],
          ),
        ),
      ),
    );
  }
} 
