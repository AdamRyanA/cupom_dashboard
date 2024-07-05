import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../utils/colors.dart';



class FullScreenImage extends StatefulWidget {
  final int initialIndex;
  final List<String> images;
  final List<Uint8List>? imagesUint8List;
  const FullScreenImage({required this.initialIndex, required this.images, this.imagesUint8List, super.key});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {

  late int currentIndex = widget.initialIndex;

  late PageController pageController = PageController(initialPage: widget.initialIndex);

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: whiteColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: blackColor,
        ),
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            PhotoViewGallery.builder(
              itemCount: widget.imagesUint8List == null
                  ? widget.images.length
                  : widget.imagesUint8List?.length,
              builder: (BuildContext context, int index) {
                if (widget.imagesUint8List != null) {
                  Uint8List imageMemory = widget.imagesUint8List![index];
                  return PhotoViewGalleryPageOptions(
                      imageProvider: MemoryImage(imageMemory),
                      initialScale: PhotoViewComputedScale.contained * 0.5,
                      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
                      maxScale: PhotoViewComputedScale.contained * 4.1,
                      heroAttributes: PhotoViewHeroAttributes(tag: index)
                  );
                }else{
                  String urlPhoto = widget.images[index];
                  return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(urlPhoto),
                      initialScale: PhotoViewComputedScale.contained * 0.5,
                      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
                      maxScale: PhotoViewComputedScale.contained * 4.1,
                      heroAttributes: PhotoViewHeroAttributes(tag: index)
                  );
                }
              },
              pageController: pageController,
              onPageChanged: onPageChanged,
              scrollPhysics: const BouncingScrollPhysics(),
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: primaryColor,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Foto ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}