// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsStateImpl _$$SettingsStateImplFromJson(Map<String, dynamic> json) =>
    _$SettingsStateImpl(
      showHeaders: json['showHeaders'] as bool,
      waitlistNotifications: json['waitlistNotifications'] as bool,
      dealsTab: $enumDecodeNullable(_$DealCategoryEnumMap, json['dealsTab']) ??
          DealCategory.all,
      dealCardType: $enumDecode(_$DealCardTypeEnumMap, json['dealCardType']),
      waitlistSorting:
          $enumDecode(_$WaitlistSortingEnumMap, json['waitlistSorting']),
      waitlistSortingDirection: $enumDecode(
          _$WaitlistSortingDirectionEnumMap, json['waitlistSortingDirection']),
      crashlyticsEnabled: json['crashlyticsEnabled'] as bool,
    );

Map<String, dynamic> _$$SettingsStateImplToJson(_$SettingsStateImpl instance) =>
    <String, dynamic>{
      'showHeaders': instance.showHeaders,
      'waitlistNotifications': instance.waitlistNotifications,
      'dealsTab': _$DealCategoryEnumMap[instance.dealsTab]!,
      'dealCardType': _$DealCardTypeEnumMap[instance.dealCardType]!,
      'waitlistSorting': _$WaitlistSortingEnumMap[instance.waitlistSorting]!,
      'waitlistSortingDirection':
          _$WaitlistSortingDirectionEnumMap[instance.waitlistSortingDirection]!,
      'crashlyticsEnabled': instance.crashlyticsEnabled,
    };

const _$DealCategoryEnumMap = {
  DealCategory.all: 'all',
  DealCategory.steam_top_sellers: 'steam_top_sellers',
  DealCategory.steam_featured: 'steam_featured',
};

const _$DealCardTypeEnumMap = {
  DealCardType.expanded: 'expanded',
  DealCardType.compact: 'compact',
};

const _$WaitlistSortingEnumMap = {
  WaitlistSorting.title: 'title',
  WaitlistSorting.date_added: 'date_added',
  WaitlistSorting.price_cut: 'price_cut',
  WaitlistSorting.discount_date: 'discount_date',
  WaitlistSorting.price: 'price',
};

const _$WaitlistSortingDirectionEnumMap = {
  WaitlistSortingDirection.asc: 'asc',
  WaitlistSortingDirection.desc: 'desc',
};
