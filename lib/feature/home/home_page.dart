import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app/base/base.dart';
import 'package:quiz_app/feature/topic/topic_page.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_share/social_share.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ScreenshotController screenshotController = ScreenshotController();

    Future<void> shareScreenshot() async {
      Uint8List? imageData = await screenshotController.capture();
      if (imageData != null) {
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/image.jpg';
        final file = File(path);
        await file.writeAsBytes(imageData);
        Share.shareFiles([path], text: 'Lets Try!');
      }
    }

    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: baseColor,
        body: Padding(
          padding: const EdgeInsets.all(70),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100,),
                const Icon(Icons.lightbulb,color: Colors.yellow,size: 100,),
                const SizedBox(height: 30,),
                const Text("Flutter Quiz App", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 24),),
                const SizedBox(height: 20,),
                const Text("Learn . Take Quiz . Repeat", style: TextStyle(color: Colors.white, fontSize: 12),),

                const SizedBox(height: 50,),

                Container(
                  width: Get.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                        )
                      ),
                      onPressed: (){
                        Get.to(()=>const TopicPage());
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text("PLAY"),
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: Get.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: baseColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(color: Colors.blue.shade400,width: 2.5)
                          )
                      ),
                      onPressed: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("TOPICS",style: TextStyle(color: Colors.blue.shade400),),
                      )
                  ),
                ),

                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: (){
                              shareScreenshot();
                            },
                            child: const Icon(Icons.share,color: Colors.blueAccent,)),
                        const Text("Share",style: TextStyle(color: Colors.white),),
                      ],
                    ),

                    Row(
                      children: [
                        InkWell(
                            onTap: (){
                            },
                            child: const Icon(Icons.star,color: Colors.yellow,)),
                        const Text("Rate us",style: TextStyle(color: Colors.white),)
                      ],
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
