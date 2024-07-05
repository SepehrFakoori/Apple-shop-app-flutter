import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final BoxFit fit;

  const CachedImage(
      {super.key, this.imageUrl, this.radius = 0.0, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: imageUrl ??
            'https://startflutter.ir/api/files/equwrpwnez9pvim/dmr9eruk9ewr12o/rectangle_64_2_ACJxwff96d.png',
        errorWidget: (context, index, error) => Container(
          color: Colors.red[100],
        ),
        placeholder: (context, url) => Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}
