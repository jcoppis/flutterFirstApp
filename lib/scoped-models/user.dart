import '../scoped-models/connected_products.dart';

import '../models/user.dart';

mixin UserModel on ConnectedProducts {
  void login(String email, String password){
    authenticatedUser = User(id: 'a', email: email, password: password);
  }
}