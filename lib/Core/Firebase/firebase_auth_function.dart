import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app_route/Models/auth_exception.dart';
import 'package:todo_app_route/Models/auth_model.dart';

import '../../Shared/Themes/app_theme.dart';
import '../../Shared/network/local/cache_helper.dart';

class FirebaseAuthFunction {
  static CollectionReference<AuthModel> getUsersCollection() =>
      FirebaseFirestore.instance.collection("Users").withConverter<AuthModel>(
            fromFirestore: (dcSnapshot, option) =>
                AuthModel.fromJson(dcSnapshot.data()!),
            toFirestore: (taskModel, option) => taskModel.toJson(),
          );

  static Future<void> addUserToFirebase(AuthModel authModel) async {
    CollectionReference<AuthModel> collectionReference = getUsersCollection();
    DocumentReference<AuthModel> documentReference =
        collectionReference.doc(authModel.id);
    return documentReference.set(authModel);
  }

  static Future<AuthModel?> getUserFromFirebase(String id) async {
    CollectionReference<AuthModel?> collectionReference = getUsersCollection();
    DocumentSnapshot<AuthModel?> documentSnapshot =
        await collectionReference.doc(id).get();
    return documentSnapshot.data();
  }

  static Future<void> authStateChanges(
    String signInMsg,
    String signOutMsg,
  ) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Fluttertoast.showToast(
          msg: signOutMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.white,
          textColor: AppTheme.black,
          fontSize: 18.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: signInMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.white,
          textColor: AppTheme.black,
          fontSize: 18.0,
        );
      }
    });
  }

  static Future createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user =
          AuthModel(id: credential.user!.uid, name: name, email: email);
      await addUserToFirebase(
        user,
      );
      await sendEmailVerification(credential.user!);
      await signOut();
      return user;
    } on FirebaseAuthException catch (e) {
      return ServerException.handleFirebaseException(e);
    }
  }

  static Future signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      return ServerException.handleFirebaseException(e);
    }
  }

  static Future sendEmailVerification(User? user) async {
    try {
      if (user == null) return;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      return user.emailVerified;
    } on FirebaseAuthException catch (e) {
      return ServerException.handleFirebaseException(e);
    }
  }

  static Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AuthModel? user = await getUserFromFirebase(credential.user!.uid);
      final isVerified = await sendEmailVerification(credential.user!);
      if (isVerified == false) {
        user = null;
      }
      await CacheHelper.saveData(key: "userId", value: credential.user!.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      return ServerException.handleFirebaseException(e);
    }
  }

  static Future sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return ServerException.handleFirebaseException(e);
    }
  }

  static Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      AuthModel? getUser = await getUserFromFirebase(userCredential.user!.uid);
      if (getUser == null) {
        final user = AuthModel(
            id: userCredential.user!.uid,
            name: googleUser.displayName.toString(),
            email: googleUser.email.toString());
        await addUserToFirebase(
          user,
        );
      }
      await CacheHelper.saveData(
          key: "userId", value: userCredential.user!.uid);
      return getUser;
    } on FirebaseAuthException catch (e) {
      return ServerException.handleFirebaseException(e);
    }
  }
}
