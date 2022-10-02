import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/repository/repository.dart';
import 'package:todo/view/base/base.dart';

abstract class LoginNavigator extends BaseNavigator {
  void goToHome();
}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var authServices = FirebaseAuth.instance;
  Repository? repository;

  LoginViewModel({this.repository});

  void login(String email, String password) async {
    navigator?.showLoading();
    try {
      var cerdintial = await authServices.signInWithEmailAndPassword(
          email: email, password: password);

      await repository?.retriveUserById(cerdintial.user?.uid ?? '');

      navigator?.goToHome();
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
}
