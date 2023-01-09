import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/base/base.dart';
import 'package:quiz_app/feature/home/home_page.dart';
import 'package:quiz_app/feature/question/question_animal/question_animal_controller.dart';

class QuestionAnimalPage extends StatelessWidget {
  QuestionAnimalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionAnimalController = Get.put(QuestionAnimalController());
    return Obx(() => Scaffold(
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
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_left,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const Text(
                    "Quiz Page",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  InkWell(
                    onTap: (){
                      Get.offAll(HomePage());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        "Exit",
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            LinearProgressIndicator(
              value: questionAnimalController.progress.value / 30,
              // backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(questionAnimalController.questionAnimalModel.isEmpty?"":"${questionAnimalController.questionAnimalModel[questionAnimalController.indexNumber.value].question}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),

                      const SizedBox(height: 10,),
                      Image.network("${questionAnimalController.questionAnimalModel.isEmpty?"https://media.istockphoto.com/id/1335247217/vector/loading-icon-vector-illustration.jpg?s=612x612&w=0&k=20&c=jARr4Alv-d5U3bCa8eixuX2593e1rDiiWnvJLgHCkQM=":questionAnimalController.questionAnimalModel[questionAnimalController.indexNumber.value].imageUrl}", scale: 3.0,),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: ListView.builder(
                // dataDraftNoo?.length??0
                  itemCount: questionAnimalController.questionAnimalModel.isEmpty?0:questionAnimalController.questionAnimalModel[questionAnimalController.indexNumber.value].answers?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    for (int i=0; i<questionAnimalController.questionAnimalModel[questionAnimalController.indexNumber.value].answers!.length;i++){
                      questionAnimalController.colorAnswer.value.add(Colors.white);
                    }
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: questionAnimalController.colorAnswer[index],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              )
                          ),
                          onPressed: () {
                            if(questionAnimalController.questionAnimalModel[questionAnimalController.indexNumber.value].answers![index]==questionAnimalController.questionAnimalModel[questionAnimalController.indexNumber.value].correctAnswer){
                              questionAnimalController.colorAnswer[index] = Colors.green;
                              Future.delayed(Duration(milliseconds: 1200),(){
                                questionAnimalController.dataAnswer.add(questionAnimalController.questionAnimalModel[questionAnimalController.indexNumber.value]);
                                questionAnimalController.correctAnswer.add(true);
                                questionAnimalController.nextQuestion();
                                questionAnimalController.colorAnswer[index] = Colors.white;
                              });
                            }else{
                              questionAnimalController.colorAnswer[index] = Colors.red;
                              Future.delayed(Duration(milliseconds: 1200),(){
                                questionAnimalController.correctAnswer.add(false);
                                // questionAnimalController.dataAnswer.add(questionAnimalController.questionAnimalModel[questionAnimalController.indexNumber.value]);
                                questionAnimalController.nextQuestion();
                                questionAnimalController.colorAnswer[index] = Colors.white;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(questionAnimalController.questionAnimalModel[questionAnimalController.indexNumber.value].answers![index],style: const TextStyle(color: Colors.black)),
                          )
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
