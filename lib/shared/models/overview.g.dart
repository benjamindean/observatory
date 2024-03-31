// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OverviewImpl _$$OverviewImplFromJson(Map<String, dynamic> json) =>
    _$OverviewImpl(
      prices: (json['prices'] as List<dynamic>?)
              ?.map((e) => OverviewPrices.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      bundles: (json['bundles'] as List<dynamic>?)
              ?.map((e) => Bundle.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OverviewImplToJson(_$OverviewImpl instance) =>
    <String, dynamic>{
      'prices': instance.prices,
      'bundles': instance.bundles,
    };

_$OverviewPricesImpl _$$OverviewPricesImplFromJson(Map<String, dynamic> json) =>
    _$OverviewPricesImpl(
      id: json['id'] as String,
      current: json['current'] == null
          ? null
          : Price.fromJson(json['current'] as Map<String, dynamic>),
      lowest: json['lowest'] == null
          ? null
          : Price.fromJson(json['lowest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OverviewPricesImplToJson(
        _$OverviewPricesImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'current': instance.current,
      'lowest': instance.lowest,
    };

_$BundleImpl _$$BundleImplFromJson(Map<String, dynamic> json) => _$BundleImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      details: json['details'] as String,
      page: BundlePage.fromJson(json['page'] as Map<String, dynamic>),
      expiry: json['expiry'] as String?,
    );

Map<String, dynamic> _$$BundleImplToJson(_$BundleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'details': instance.details,
      'page': instance.page,
      'expiry': instance.expiry,
    };

_$BundlePageImpl _$$BundlePageImplFromJson(Map<String, dynamic> json) =>
    _$BundlePageImpl(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$BundlePageImplToJson(_$BundlePageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
