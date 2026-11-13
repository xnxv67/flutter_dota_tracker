import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class RemoteImage extends StatelessWidget {
  const RemoteImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: url.isEmpty
          ? _placeholder(showIcon: true)
          : CachedNetworkImage(
              imageUrl: url,
              width: width,
              height: height,
              fit: fit,
              placeholder: (context, value) => _placeholder(),
              errorWidget: (context, value, error) => _placeholder(showIcon: true),
            ),
    );
  }

  Widget _placeholder({bool showIcon = false}) {
    return Container(
      width: width,
      height: height,
      color: AppColors.surfaceLight,
      alignment: Alignment.center,
      child: showIcon
          ? const Icon(Icons.sports_esports, color: AppColors.muted)
          : null,
    );
  }
}
