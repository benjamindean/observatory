import 'package:freezed_annotation/freezed_annotation.dart';

part 'steam_featured_item.freezed.dart';
part 'steam_featured_item.g.dart';

@freezed
class SteamFeaturedItem with _$SteamFeaturedItem {
  const factory SteamFeaturedItem({
    required int id,
    required String name,
    int? type,
    bool? discounted,
    String? currency,
    @JsonKey(name: 'discount_percent') int? discountpPercent,
    @JsonKey(name: 'original_price') int? originalPrice,
    @JsonKey(name: 'final_price') int? finalPrice,
    @JsonKey(name: 'large_capsule_image') String? largeCapsuleImage,
    @JsonKey(name: 'small_capsule_image') String? smallCapsuleImage,
    @JsonKey(name: 'windows_available') bool? windowsAvailable,
    @JsonKey(name: 'mac_available') bool? macAvailable,
    @JsonKey(name: 'linux_available') bool? linuxAvailable,
    @JsonKey(name: 'streamingvideo_available') bool? streamingvideoAvailable,
    @JsonKey(name: 'discount_expiration') num? discountExpiration,
    @JsonKey(name: 'header_image') String? headerImage,
  }) = _SteamFeaturedItem;

  factory SteamFeaturedItem.fromJson(Map<String, Object?> json) =>
      _$SteamFeaturedItemFromJson(json);
}
