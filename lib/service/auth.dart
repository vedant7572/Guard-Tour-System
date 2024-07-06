import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final FirebaseAuth auth=FirebaseAuth.instance;

  getCurrentUser() async{
    return await auth.currentUser;
  }

  Future signOut() async{
    await FirebaseAuth.instance.signOut();
    //await SharedPreferenceHelper().clear();
  }

  Future deleteUser() async{
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();
      //await SharedPreferenceHelper().clear();
    }
  }

}