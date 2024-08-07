import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:cipher_guard/controllers/login_controller.dart';
import 'package:cipher_guard/widgets/my_button.dart';
import 'package:cipher_guard/widgets/textField.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            backgroundColor: Colors.grey[900],
            body: Obx(
              () => ListView(
                children: (controller.isLogin.value)
                    ? _buildLogin(context)
                    : _buildSignup(context),
              ),
            )));
  }

  List<Widget> _buildLogin(BuildContext context) {
    controller.passwordController = TextEditingController();
    controller.passValidate = RxBool(false);
    return <Widget>[
      AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
        title: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      const SizedBox(
        height: 16,
      ),
      Obx(() => controller.user.value),
      const SizedBox(
        height: 16,
      ),
      TypeAheadField(
        textFieldConfiguration: const TextFieldConfiguration(
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          autofillHints: ["AutoFillHints 1", "AutoFillHints 2"],
          autofocus: true,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(color: Colors.teal, width: 1.5)),
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: Colors.white54),
            label: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white54,
                ),
                Text("Search by name")
              ],
            ),
          ),
        ),
        suggestionsCallback: (pattern) async {
          return await controller.app.searchUser(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text("${suggestion.firstName} ${suggestion.lastName}"),
          );
        },
        itemSeparatorBuilder: (context, index) {
          return const Divider();
        },
        onSuggestionSelected: (s) {
          controller.getUser(s.id);
        },
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 8.0,
        ),
      ),
      Obx(() => MyField(
          controller: controller.passwordController,
          validate: controller.passValidate!.value,
          errorText: "password not correct",
          hintText: "Password")),
      MyButton(
        onTap: () {
          if (controller.tempUser == null) {
            SnackBar snackBar = const SnackBar(
                content: Text("please select user first or try to signup"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            if (controller.tempUser!.password ==
                controller.passwordController.text) {
              controller.login(controller.tempUser!);
            } else {
              controller.passValidate!.value = true;
            }
          }
        },
        label: 'Login',
      ),
      MyButton(
          onTap: () {
            controller.tempUser = null;
            controller.passwordController.clear();
            controller.isLogin.value = false;
          },
          label: 'Signup')
    ];
  }

  List<Widget> _buildSignup(BuildContext context) {
    controller.iniControllers();
    return <Widget>[
      AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
        title: const Text("Signup", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      const SizedBox(
        height: 16,
      ),
      Obx(() =>MyField(
          controller: controller.firstNameController,
          validate: controller.firstValidate!.value,
          errorText: "at least 3 characters first name",
          hintText: "First Name")),
      Obx(() => MyField(
          controller: controller.lastNameController,
          validate: controller.lastValidate!.value,
          errorText: "at least 3 characters last name",
          hintText: "Last Name")),
      Obx(() =>MyField(
          controller: controller.passwordController,
          validate: controller.passValidate!.value,
          errorText: "please enter password with at least 8 characters",
          hintText: "Password")),
      MyButton(
          onTap: () async {
            if (controller.firstNameController.text.length < 3) {
              controller.firstValidate!.value = true;
            }
            if (controller.lastNameController.text.length < 3) {
              controller.lastValidate!.value = true;
            }
            if (controller.passwordController.text.length < 8) {
              controller.passValidate!.value = true;
            }
            if (controller.firstNameController.text.length >= 3 &&
                controller.lastNameController.text.length >= 3 &&
                controller.passwordController.text.length >= 8) {
              await controller.createUser();
            }
          },
          label: "SignUp"),
      MyButton(
          onTap: () {
            controller.firstNameController.clear();
            controller.lastNameController.clear();
            controller.passwordController.clear();
            controller.isLogin.value = true;
          },
          label: "Login")
    ];
  }
}
