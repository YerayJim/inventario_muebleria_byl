class AuthService {
  Future<bool> authenticate(String email, String password) async {
    // Simula una llamada a API
    await Future.delayed(const Duration(seconds: 2));
    return email == 'admin@example.com' && password == '123456';
  }
}

