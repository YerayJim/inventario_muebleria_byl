import 'package:inventario_muebleria_byl/modules/auth/services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<bool> login(String email, String password) async {
    return await _authService.authenticate(email, password);
  }
}
