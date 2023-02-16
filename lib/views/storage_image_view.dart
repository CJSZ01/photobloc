// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageImageView extends StatelessWidget {
  const StorageImageView({
    Key? key,
    required this.image,
  }) : super(key: key);
  final Reference image;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: image.getData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const CircularProgressIndicator();

          case ConnectionState.done:
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Image.memory(
                data,
                fit: BoxFit.cover,
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'An error ocurred while fetching images',
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
        }
      },
    );
  }
}
