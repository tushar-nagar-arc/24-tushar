import 'dart:developer';

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
    log("add function");
    final favourites = Hive.box("favourites");
    List<String>? favouriteList = getFavourite() ?? [];
    if(favouriteList.contains(url)){
      return;
    }
    favouriteList.add(url);
    favourites.put("favourites", favouriteList);
  }

  static List<String>? getFavourite(){
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