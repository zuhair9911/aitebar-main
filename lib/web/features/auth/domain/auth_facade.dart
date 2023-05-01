abstract class IAdminAuthFacade {
  Future<dynamic> login(String email, String password);

  Future<void> signOut();
}
