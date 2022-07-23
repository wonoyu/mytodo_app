import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/constants/key_constants.dart';
import 'package:mytodo_app/src/features/username_auth/domain/username_auth_repository.dart';

class UsernameAuthController extends StateNotifier<AsyncValue<String>> {
  UsernameAuthController({required this.usernameAuthRepository})
      : super(const AsyncValue.loading()) {
    getUsername();
  }

  final UsernameAuthRepository usernameAuthRepository;

  Future<void> setUsername(String username) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() =>
        usernameAuthRepository.setUsername(username, KeyConstants.usernameKey));
  }

  void getUsername() {
    state = AsyncValue.data(
        usernameAuthRepository.getUsername(KeyConstants.usernameKey));
  }
}

final usernameAuthControllerProvider = StateNotifierProvider.autoDispose<
    UsernameAuthController, AsyncValue<String>>((ref) {
  return UsernameAuthController(
      usernameAuthRepository: ref.watch(usernameAuthRepositoryProvider));
});
