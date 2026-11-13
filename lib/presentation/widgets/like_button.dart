import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({super.key, required this.liked, required this.onPressed});

  final bool liked;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        liked ? Icons.favorite : Icons.favorite_border,
        color: liked ? AppColors.red : AppColors.muted,
      ),
    );
  }
}
