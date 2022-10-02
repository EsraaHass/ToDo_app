import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/repository/repository.dart';
import 'package:todo/view/base/base.dart';
import 'package:todo/view/shared/shared_data.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void goToHome();
}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Repository? repository;

  RegisterViewModel({this.repository});

  void createAccount(String name, String email, String password) async {
    navigator?.showLoading();
    try {
      var cerdintial = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      MyUser myUser = MyUser(
          id: cerdintial.user?.uid,
          name: name,
          password: password,
          email: email);

      var insertedUser = await repository?.insertUser(myUser);

      navigator?.hideLoading();
      if (insertedUser != null) {
        SharedData.myUser = insertedUser;
        navigator?.goToHome();
      } else {
        navigator
            ?.showMessage('something went wrong with username or password');
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoading();
      if (e.code == 'weak-password') {
        navigator?.showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage('something went wrong, please try again.');
    }
  }

  void loginWithFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult result =
        await facebookLogin.logIn(customPermissions: ['email']);
    final accessToken = result.accessToken?.token;
    if (result.status == FacebookLoginStatus.success) {
      final facecerdintial = FacebookAuthProvider.credential(accessToken!);
      await auth.signInWithCredential(facecerdintial);
    }
  }
}
