import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipher_guard/controllers/encryptions_controller.dart';

class EncryptionsScreen extends GetView<EncryptionsController> {
  const EncryptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey[900],
          title: Text(
            "Encryptions by ${controller.app.currentUser!.firstName.capitalize}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: Obx(() => (controller.isLoaded.value)
            ? _buildList()
            : const Center(child: CircularProgressIndicator())));
  }

  Widget _buildList() {
    return ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: (controller.encList.isNotEmpty)
            ? List.generate(
                controller.encList.length,
                (index) => Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      title: Text(
                        controller.encList[index].algoName,
                        style: const TextStyle(color: Colors.teal),
                      ),
                      subtitle: Text(
                        controller.encList[index].fileName,
                        style: const TextStyle(color: Colors.white60),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${controller.encList[index].time} ms",
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            controller.getDate(controller.encList[index].date),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
              )
            : [
                const Center(
                  child: Text(
                    "Encryptions list is empty",
                    style: TextStyle(color: Colors.white60),
                  ),
                )
              ]);
  }
}
