import 'package:firebase_1/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider =
    Provider((ref) => AuthRepository(FirebaseAuth.instance));

final authStateChangesProvider =
    StreamProvider((ref) => ref.read(authRepositoryProvider).authStateChanges);
