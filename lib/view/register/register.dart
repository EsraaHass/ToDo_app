import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/repository/repository_impl.dart';
import 'package:todo/view/base/base.dart';
import 'package:todo/view/home_screen.dart';
import 'package:todo/view/list/main_button.dart';
import 'package:todo/view_model/register_viewmodel.dart';

import '../login/Login.dart';

class Register extends StatefulWidget {
  static const String routeName = 'Register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends BaseState<Register, RegisterViewModel>
    implements RegisterNavigator {
  var formKey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var nameFocusNode = FocusNode();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel(repository: AddTaskRepository());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            child: Form(
              key: formKey,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          children: [
                            TextFormField(
                              focusNode: nameFocusNode,
                              keyboardType: TextInputType.name,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(emailFocusNode),
                              textInputAction: TextInputAction.next,
                              controller: namecontroller,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'please enter name';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter Your Name',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              focusNode: emailFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(passwordFocusNode),
                              textInputAction: TextInputAction.next,
                              controller: emailcontroller,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'please enter email';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter Your Email',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              focusNode: passwordFocusNode,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              controller: passwordcontroller,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'please enter password';
                                }
                                if (text.length < 6) {
                                  return 'password should be at least 6 chars';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter Your Password',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: () {},
                              child: const Text('Forget Your Password ?')),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        MainButton(
                            text: 'Register',
                            voidCallback: () {
                              register();
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => Login()));
                              },
                              child: const Text('Already Have Account? Login')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      viewModel.createAccount(
          namecontroller.text, emailcontroller.text, passwordcontroller.text);
    }
  }

  @override
  void goToHome() {
    formKey.currentState!.reset();
    Navigator.pushNamed(context, HomeScreen.routeName);
  }
}
