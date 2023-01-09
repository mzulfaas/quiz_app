import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quiz_app/feature/home/home_page.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../base/base.dart';

class ScorePage extends StatelessWidget {
  List dataCorrectAnswer;
  List dataAnswer;
  ScorePage({Key? key, required this.dataCorrectAnswer, required this.dataAnswer}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    var scoreCorrectCount = dataCorrectAnswer.where((element) => element==true).length;
    var finalScore = 100/3 * scoreCorrectCount;

    final dataMap = <String, double>{
      "Correct": finalScore,
    };

    final colorList = <Color>[
      Colors.greenAccent,
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Screenshot(
        controller: screenshotController,
        child: Scaffold(
          backgroundColor: baseColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.offAll(const HomePage());
                          Get.clearRouteTree();
                          Get.deleteAll(force: true);
                          dataCorrectAnswer.clear();
                          dataAnswer.clear();
                        },
                        icon: const Icon(
                          Icons.arrow_left,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Get.width-300),
                        child: const Text(
                          "Your Score",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PieChart(
                    dataMap: dataMap,
                    chartType: ChartType.ring,
                    baseChartColor: Colors.orange,
                    ringStrokeWidth: 8,
                    chartRadius: 150,
                    colorList: colorList,
                    centerText: "$scoreCorrectCount/3",
                    legendOptions: const LegendOptions(
                      showLegends: false,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      // showChartValuesInPercentage: true,
                        showChartValues: false
                    ),
                    totalValue: 100,
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: 175,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: ()=>shareScreenshot(),
                      child: const Text("Share your score"),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text("Your Report",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 24),),
                const SizedBox(height: 20,),
                ListView.builder(
                    itemCount: dataAnswer.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      final jsonMapQuestion = jsonDecode(jsonEncode(dataAnswer[index])) as Map<String, dynamic>;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20,left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${jsonMapQuestion['question']}",style: const TextStyle(color: Colors.white),),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                dataCorrectAnswer[index]==true?const Icon(Icons.check,color: Colors.green,):const Icon(Icons.close_rounded,color: Colors.red,),
                                const SizedBox(width: 4,),
                                dataCorrectAnswer[index]==true?Expanded(child: Text("${jsonMapQuestion['correctAnswer']}",style: const TextStyle(color: Colors.white),)):const SizedBox(),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
