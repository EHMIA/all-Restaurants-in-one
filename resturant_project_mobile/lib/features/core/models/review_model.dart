import 'dart:io';

class ReviewModel {
  final String id;
  final String userName;
  final String userProfileImage;
  final double rating;
  final String reviewTitle;
  final String reviewText;
  final List<File> images;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.userProfileImage,
    required this.rating,
    required this.reviewTitle,
    required this.reviewText,
    required this.images,
    required this.createdAt,
  });

  /// Get time ago string
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks weeks ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months months ago';
    }
  }
}
