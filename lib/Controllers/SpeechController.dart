import 'package:get/get.dart';
import 'dart:async';
import 'dart:math';

import 'package:speech_to_text/speech_to_text.dart';

class SpeechController extends GetxController{

    final SpeechToText _speechToText = SpeechToText();
    SpeechToText get speechToText => _speechToText;

    RxBool speechEnabled = false.obs;
    RxString wordsSpoken = "".obs;
    RxDouble confidenceLevel = 0.0.obs;
    RxBool isListening = false.obs;


    @override
    void onInit(){
      super.onInit();
      initSpeech();
    }

    void initSpeech()async{
      speechEnabled.value = await speechToText.initialize();
    }

    void startListening() async{
      bool available = await speechToText.initialize(
         onStatus: (status){
           // print("STATUS: $status");
            if(status=="listening"){
              isListening.value = true;
            }
            if(status=="notListening"){
              isListening.value=false;
            }
         },
         onError: (error){
          // print("ERROR: $error");
         }
      );

      if (!available) {
        speechEnabled.value = false;
        return;
      }

      await speechToText.listen(onResult: onSpeechResult);
      isListening.value = true;
      confidenceLevel.value = 0.0;
    }

    void onSpeechResult(result) async{
      wordsSpoken.value = "${result.recognizedWords}";
      confidenceLevel.value = result.confidence;
    }

    void stopListening() async{
       await speechToText.stop();
       isListening.value = false;
    }

}

