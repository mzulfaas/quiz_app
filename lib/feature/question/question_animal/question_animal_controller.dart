import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quiz_app/feature/question/score_page.dart';
import 'package:quiz_app/model/question_animal_model.dart';

class QuestionAnimalController extends GetxController with GetTickerProviderStateMixin{

  RxInt progress = 0.obs;
  RxBool answer = false.obs;
  RxInt indexNumber = 0.obs;
  RxList colorAnswer = [].obs;


  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('questionAnimals');

  RxList<QuestionAnimalModel> questionAnimalModel = <QuestionAnimalModel>[].obs;
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    questionAnimalModel.addAll(allData.map((e) => QuestionAnimalModel.fromJson(e)));
    update();
  }

  RxList correctAnswer = [].obs;
  RxList dataAnswer = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    indexNumber.value=0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      progress.value++;
      if (progress.value % 30 == 0) {
        if(indexNumber.value == indexNumber.value && indexNumber.value != questionAnimalModel.length-1){
          dataAnswer.add(questionAnimalModel[indexNumber.value]);
          correctAnswer.add(false);
        }
        indexNumber.value == questionAnimalModel.length-1?indexNumber.value:indexNumber.value++;

        progress.value = 0;

      }
      if (indexNumber.value == questionAnimalModel.length) {
        indexNumber.value = questionAnimalModel.length-1;
        dataAnswer.add(questionAnimalModel[indexNumber.value]);
        correctAnswer.add(false);
        Get.offAll(ScorePage(
          dataCorrectAnswer: correctAnswer,
          dataAnswer: dataAnswer,
        ));
        timer.cancel();
      }
      update();
    });
  }

  nextQuestion(){
    if(indexNumber.value == questionAnimalModel.length-1){
      dataAnswer.add(questionAnimalModel[indexNumber.value]);
      Get.offAll(ScorePage(
        dataCorrectAnswer: correctAnswer,
        dataAnswer: dataAnswer,
      ));
    }else{
      indexNumber.value++;
    }
    update();
  }

}