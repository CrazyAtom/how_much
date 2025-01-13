import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:how_much/common/const/data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/provider/firebase_provider.dart';
import '../../common/provider/secure_storage_provider.dart';
import '../model/user_model.dart';

part 'auth_repository.g.dart';

@riverpod
class AuthRepository extends _$AuthRepository {
  @override
  FutureOr<void> build() async {}

  FirebaseAuth get firebaseAuth => ref.watch(firebaseAuthProvider);
  FlutterSecureStorage get secureStorage => ref.watch(secureStorageProvider);

  Future<UserModel?> signInAnonymously() async {
    try {
      final userCredential = await firebaseAuth.signInAnonymously();
      final user = userCredential.user;
      if (user != null) {
        await secureStorage.write(
            key: StorageKeys.userUid.key, value: user.uid);
        return UserModel.fromFirebaseUser(user);
      }
      throw Exception('로그인에 실패했습니다.');
    } on FirebaseAuthException catch (e) {
      throw Exception('로그인 오류: ${e.message}');
    } catch (e) {
      throw Exception('알 수 없는 오류가 발생했습니다.');
    }
  }

  Future<UserModel?> autoSignIn() async {
    try {
      final storageUid = await secureStorage.read(key: StorageKeys.userUid.key);
      if (storageUid != null) {
        final user = firebaseAuth.currentUser;
        if (user != null && user.uid == storageUid) {
          return UserModel.fromFirebaseUser(user);
        }
      }
      return null;
    } catch (e) {
      throw Exception('자동 로그인 중 오류가 발생했습니다.');
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    return null;

    // Google 로그인 구현 예정
  }

  Future<UserModel?> signInWithApple() async {
    return null;

    // Apple 로그인 구현 예정
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      await secureStorage.delete(key: StorageKeys.userUid.key);
    } catch (e) {
      throw Exception('로그아웃 중 오류가 발생했습니다.');
    }
  }
}
