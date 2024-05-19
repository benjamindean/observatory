// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steam_featured_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SteamFeaturedItemImpl _$$SteamFeaturedItemImplFromJson(
        Map<String, dynamic> json) =>
    _$SteamFeaturedItemImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: (json['type'] as num?)?.toInt(),
      discounted: json['discounted'] as bool?,
      currency: json['currency'] as String?,
      discountpPercent: (json['discount_percent'] as num?)?.toInt(),
      originalPrice: (json['original_price'] as num?)?.toInt(),
      finalPrice: (json['final_price'] as num?)?.toInt(),
      largeCapsuleImage: json['large_capsule_image'] as String?,
      smallCapsuleImage: json['small_capsule_image'] as String?,
      windowsAvailable: json['windows_available'] as bool?,
      macAvailable: json['mac_available'] as bool?,
      linuxAvailable: json['linux_available'] as bool?,
      streamingvideoAvailable: json['streamingvideo_available'] as bool?,
      discountExpiration: json['discount_expiration'] as num?,
      headerImage: json['header_image'] as String?,
    );

Map<String, dynamic> _$$SteamFeaturedItemImplToJson(
        _$SteamFeaturedItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'discounted': instance.discounted,
      'currency': instance.currency,
      'discount_percent': instance.discountpPercent,
      'original_price': instance.originalPrice,
      'final_price': instance.finalPrice,
      'large_capsule_image': instance.largeCapsuleImage,
      'small_capsule_image': instance.smallCapsuleImage,
      'windows_available': instance.windowsAvailable,
      'mac_available': instance.macAvailable,
      'linux_available': instance.linuxAvailable,
      'streamingvideo_available': instance.streamingvideoAvailable,
      'discount_expiration': instance.discountExpiration,
      'header_image': instance.headerImage,
    };
