import 'dart:developer';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gif/core/constants/api_keys.dart';
import 'package:gif/core/constants/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GifController extends GetxController {
  List<String> _gifs = [];

  List<String> get gifs => _gifs;
  bool loadMore = true;
  final int limit=25;
  int page = 25;
  RxString searchStr = "".obs;
  
  Future fetchTrendingGifs() async {
    ApiKeyProvider.selectKey();
    final uri = Uri.parse(
        "${searchStr.value.isEmpty ? AppUrls.trendingUrl : AppUrls.searchUrl}?api_key=${ApiKeys.androidApiKey}&q=${searchStr.value}&offset=$page&limit=$limit");
    try {
      final response = await http.get(uri);
      final decodedResponse = json.decode(response.body);
      log("$decodedResponse");
      if (response.statusCode == 200) {
        // loadMore = !decodedResponse['data'].isEmpty();
        // page = loadMore == true ? page+1 : page; 
        if(decodedResponse['data'].isEmpty){
          loadMore=false;
        }
        decodedResponse['data'].forEach((element) {
          _gifs.add(element['images']['original']['url']);
        });
        log("list of gifs $_gifs");
        update();
      }
      else{
        throw "something went wrong";
      }
    } catch (e) {
      log("$e");
      rethrow;
    }
  }
  
  @override
  void onInit() {
    fetchTrendingGifs();

    ever(searchStr, (val){
      loadMore=true;
      page=1;
      gifs.clear();
      fetchTrendingGifs();
      const Duration(seconds: 1);
    });

    super.onInit();
  }


}
