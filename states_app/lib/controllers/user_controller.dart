import 'package:get/get.dart';
import 'package:states_app/models/user.dart';

class UserController extends GetxController {
  RxBool existUser = false.obs;
  Rx<User> user = new User().obs;

  int get professionsCount {
    return this.user.value.professions.length;
  }

  void loadUser( User newUser ) {
    this.existUser.value = true;
    this.user.value = newUser;
  }

  void changeAge( int age ) {
    this.user.update((val) {
      val!.age = age;
    });
  }

  void addProfession( String profession ) {
    this.user.update((val) {
      val!.professions = [ ...val.professions, profession ];
    });
  }
  
}