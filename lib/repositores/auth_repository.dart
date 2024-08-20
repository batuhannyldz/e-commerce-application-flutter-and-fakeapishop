import 'package:fakeapi/models/login_model.dart';
import 'package:fakeapi/services/auth_service.dart';


class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future<User> login(String username, String password) async {
    final token = await authService.login(username, password);

    if (token != null) {
      // Token ve kullanıcı bilgilerini almak için başka bir API çağrısı yapabilirsin
      // Örneğin, kullanıcı bilgilerini alma
      final user = User(
        id: 1, // Bu kısımda API'den gelen ID'yi kullanmalısın
        username: username,
        email: 'test@example.com', // Bu kısımda API'den gelen email'i kullanmalısın
        phone: '1234567890', // Bu kısımda API'den gelen phone'u kullanmalısın
        token: token,
      );
      return user;
    } else {
      throw Exception('Failed to login');
    }
  }
}