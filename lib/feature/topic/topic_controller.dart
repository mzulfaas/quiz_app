import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quiz_app/model/topics_model.dart';

class TopicController extends GetxController{

  final CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('topics');

  RxList<TopicsModel> topicsModel = <TopicsModel>[].obs;
  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    allData.shuffle();
    topicsModel.addAll(allData.map((e) => TopicsModel.fromJson(e)));
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

}