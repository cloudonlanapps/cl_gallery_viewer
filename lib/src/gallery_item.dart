import 'package:flutter/foundation.dart';

enum GalleryItemType { image, video, pdf }

@immutable
class GalleryItem {
  const GalleryItem({
    required this.id,
    required this.url,
    required this.type,
    this.previewUrl,
  });

  factory GalleryItem.image(String url, {String? id, String? previewUrl}) {
    return GalleryItem(
      id: id ?? url,
      url: url,
      type: GalleryItemType.image,
      previewUrl: previewUrl,
    );
  }

  factory GalleryItem.video(String url, {String? id, String? previewUrl}) {
    return GalleryItem(
      id: id ?? url,
      url: url,
      type: GalleryItemType.video,
      previewUrl: previewUrl,
    );
  }

  factory GalleryItem.pdf(String url, {String? id, String? previewUrl}) {
    return GalleryItem(
      id: id ?? url,
      url: url,
      type: GalleryItemType.pdf,
      previewUrl: previewUrl,
    );
  }

  final String id;
  final String url;
  final GalleryItemType type;

  /// Where this item's still preview lives, when the caller knows.
  ///
  /// Left null, a preview is derived from [url] by rewriting it into a
  /// sibling path (`clip.mp4` → `clip_poster.webp`), which is right for a
  /// static file tree and wrong for anything else. A server that addresses
  /// media by id keeps the preview at the same address under a different
  /// query, so it cannot be derived at all — such a caller sets this.
  final String? previewUrl;

  bool get isImage => type == GalleryItemType.image;
  bool get isVideo => type == GalleryItemType.video;
  bool get isPdf => type == GalleryItemType.pdf;

  GalleryItem copyWith({
    String? id,
    String? url,
    GalleryItemType? type,
    String? previewUrl,
  }) {
    return GalleryItem(
      id: id ?? this.id,
      url: url ?? this.url,
      type: type ?? this.type,
      previewUrl: previewUrl ?? this.previewUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GalleryItem &&
        other.id == id &&
        other.url == url &&
        other.type == type &&
        other.previewUrl == previewUrl;
  }

  @override
  int get hashCode =>
      id.hashCode ^ url.hashCode ^ type.hashCode ^ previewUrl.hashCode;

  @override
  String toString() =>
      'GalleryItem(id: $id, url: $url, type: $type, '
      'previewUrl: $previewUrl)';
}
