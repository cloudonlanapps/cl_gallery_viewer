import 'package:flutter/foundation.dart';

enum GalleryItemType { image, video, pdf }

@immutable
class GalleryItem {
  const GalleryItem({
    required this.id,
    required this.url,
    required this.type,
    required this.previewUrl,
  });

  factory GalleryItem.image(
    String url, {
    required String? previewUrl,
    String? id,
  }) {
    return GalleryItem(
      id: id ?? url,
      url: url,
      type: GalleryItemType.image,
      previewUrl: previewUrl,
    );
  }

  factory GalleryItem.video(
    String url, {
    required String? previewUrl,
    String? id,
  }) {
    return GalleryItem(
      id: id ?? url,
      url: url,
      type: GalleryItemType.video,
      previewUrl: previewUrl,
    );
  }

  factory GalleryItem.pdf(
    String url, {
    required String? previewUrl,
    String? id,
  }) {
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

  /// Where this item's still preview lives, or null when it has none.
  ///
  /// Required, so every caller answers; nullable, so "there is no preview"
  /// is a sayable answer. Null gets the package's placeholder — the package
  /// never derives a URL the caller did not choose. An image is its own
  /// preview and passes null.
  ///
  /// A static file tree that keeps previews as sibling files can still say
  /// so at the call site: `previewUrl: VideoUrlUtils.getPosterUrl(url)`.
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
