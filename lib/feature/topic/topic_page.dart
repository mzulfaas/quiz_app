import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/base/base.dart';
import 'package:quiz_app/feature/question/question_animal/question_animal_page.dart';
import 'package:quiz_app/feature/topic/topic_controller.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topicController = Get.put(TopicController());
    return Obx(() => Scaffold(
      backgroundColor: baseColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: Get.width-280),
                  child: const Text(
                    "Topics",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
                itemCount: topicController.topicsModel.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Get.to(QuestionAnimalPage());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                          color: baseColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              "${topicController.topicsModel[index].topicsName}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    ));
  }
}
