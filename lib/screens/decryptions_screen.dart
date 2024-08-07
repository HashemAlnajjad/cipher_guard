import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipher_guard/controllers/decryptions_controller.dart';

class DecryptionsScreen extends GetView<DecryptionsController> {
  const DecryptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey[900],
          title: Text(
            "Decryptions by ${controller.app.currentUser!.firstName.capitalize}",
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
        children: (controller.decList.isNotEmpty)
            ? List.generate(
                controller.decList.length,
                (index) => Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      title: Text(
                        controller.decList[index].algoName,
                        style: const TextStyle(color: Colors.teal),
                      ),
                      subtitle: Text(
                        controller.decList[index].fileName,
                        style: const TextStyle(color: Colors.white60),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${controller.decList[index].time} ms",
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            controller.getDate(controller.decList[index].date),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
              )
            : [
                const Center(
                  child: Text("Decryptions list is empty",
                      style: TextStyle(
                        color: Colors.white60,
                      )),
                )
              ]);
  }
}
