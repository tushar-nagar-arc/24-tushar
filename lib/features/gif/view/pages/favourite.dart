import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gif/core/services/local_storage.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favourites"),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
          itemCount: LocalStorage.getFavourite() != null ? LocalStorage.getFavourite()!.length : 0,
          itemBuilder: (context, index) {
            return CachedNetworkImage(imageUrl: LocalStorage.getFavourite()!.elementAt(index));
          },
        ),
      ),
    );
  }
}