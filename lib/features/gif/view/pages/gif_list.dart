import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:gif/core/services/local_storage.dart';
import 'package:gif/features/auth/view/pages/sign_in.dart';
import 'package:gif/features/auth/view/pages/sign_up.dart';
import 'package:gif/features/gif/view/pages/favourite.dart';
import 'package:gif/features/gif/view_models/gif_controller.dart';

class GifList extends StatelessWidget {
   GifList({super.key});
  
  @override
  Widget build(BuildContext context) {
    GifController _gifController = Get.put(GifController());
    return Scaffold(
      
      appBar: AppBar(
        leadingWidth: 100,
        leading: 
        LocalStorage.getUserInfo() != null ?
        GestureDetector(
          onTap: () async {
            LocalStorage().cleanApp();
            Get.offAll(SignUp());
          },
          child: const Padding(
            padding: const EdgeInsets.only(top:24.0,left: 10),
            child: const Text("Logout"),
          ),
        ) : GestureDetector(
          onTap: () async {
            // LocalStorage().cleanApp();
            Get.offAll(SignIn());
          },
          child: const Padding(
            padding: const EdgeInsets.only(top:24.0,left: 10),
            child: const Text("Login"),
          )),
        title: Text(LocalStorage.getUserInfo() ?? "Gifs"),
      actions: [
        Padding(
        padding: const EdgeInsets.all(16.0),
        child: IconButton(
          onPressed: () {
            Get.to(const FavouritePage());
          },
          icon: const Icon(Icons.favorite_outline)),
        ),
       ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<GifController>(
          builder: (_) {
            return Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(contentPadding: EdgeInsets.all(12),border: OutlineInputBorder(),hintText: "Search"),
                  onChanged: (value) {
                    _gifController.searchStr.value=value;
                  },
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: GridView.builder(
                  itemCount: _gifController.gifs.length+1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10), 
                  itemBuilder: (context, index) {
                    if(index == _gifController.gifs.length){
                      _gifController.loadMore ? _gifController.fetchTrendingGifs() : null;
                      return _gifController.loadMore ? const Center(child: CircularProgressIndicator(),) : Container(); 
                    }else{
                      return Stack(children: [
                        CachedNetworkImage(imageUrl: _gifController.gifs[index],),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            radius: 18,
                            child: IconButton(
                              onPressed: (){
                              LocalStorage.getUserInfo() != null ?
                              LocalStorage.addToFavourite(_gifController.gifs[index]).then((val){
                                Get.snackbar("Success", "Added to the favourites list");
                              }) :
                                Get.offAll(SignUp(),);
                            }, icon: const Icon(Icons.favorite_outline),iconSize: 24,padding: const EdgeInsets.all(0),),
                          ),
                        ),
                    ]);
                  } 
                  },
                 ),
                ),
             ]
           );
          },
        ),
        ),
    );
  }
}