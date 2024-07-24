import 'package:get/get_instance/get_instance.dart';
import 'package:hive/hive.dart';

class LocalStorage {
  

  static Future storeUserInfo(String email) async {
    final user = Hive.box("user");
    await user.put("user", email);
  }

  static String? getUserInfo(){
    final user = Hive.box("user");
    return user.get("user");
  } 

  static Future addToFavourite(String url) async{
    final favourites = Hive.box("favourites");
    Set<String>? favouriteList = getFavourite() ?? Set();
    favouriteList.add(url);
    favourites.put("favourites", favouriteList);
  }

  static Set<String>? getFavourite(){
    final favourites = Hive.box("favourites");
    return favourites.get("favourites");
  }

  Future cleanApp() async {
    final userbox = Hive.box("user");
    final favouritesBox = Hive.box("favourites");
    await Future.wait([
      userbox.clear(),
      favouritesBox.clear()
    ]);
    
  }
  
  
}