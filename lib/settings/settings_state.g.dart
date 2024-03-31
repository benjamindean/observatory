// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsStateImpl _$$SettingsStateImplFromJson(Map<String, dynamic> json) =>
    _$SettingsStateImpl(
      showHeaders: json['showHeaders'] as bool,
      waitlistNotifications: json['waitlistNotifications'] as bool,
      selectedCountry: json['selectedCountry'] as String,
      selectedStores: (json['selectedStores'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      stores: (json['stores'] as List<dynamic>)
          .map((e) => Store.fromJson(e as Map<String, dynamic>))
          .toList(),
      dealsTab: $enumDecode(_$DealCategoryEnumMap, json['dealsTab']),
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
      'selectedCountry': instance.selectedCountry,
      'selectedStores': instance.selectedStores,
      'stores': instance.stores,
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
  WaitlistSorting.date_added: 'date_added',
  WaitlistSorting.price_cut: 'price_cut',
  WaitlistSorting.price: 'price',
  WaitlistSorting.title: 'title',
};

const _$WaitlistSortingDirectionEnumMap = {
  WaitlistSortingDirection.asc: 'asc',
  WaitlistSortingDirection.desc: 'desc',
};
