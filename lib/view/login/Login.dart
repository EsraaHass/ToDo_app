import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/repository/repository_impl.dart';
import 'package:todo/view/base/base.dart';
import 'package:todo/view/home_screen.dart';
import 'package:todo/view/list/main_button.dart';
import 'package:todo/view/register/register.dart';
import 'package:todo/view_model/login_viewModel.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends BaseState<Login, LoginViewModel>
    implements LoginNavigator {
  var formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel(repository: AddTaskRepository());
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    focusNode: emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(passwordFocusNode),
                    textInputAction: TextInputAction.next,
                    controller: emailcontroller,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter email';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black, fontSize: 15),
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
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter Your Password',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                      text: 'Login',
                      voidCallback: () {
                        login();
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Register()));
                        },
                        child: const Text('Don\'t Have Account? Register')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      viewModel.login(emailcontroller.text, passwordcontroller.text);
    }
  }

  @override
  void goToHome() {
    formKey.currentState!.reset();
    Navigator.pushNamed(context, HomeScreen.routeName);
  }
}
