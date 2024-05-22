import 'package:observatory/settings/settings_repository.dart';

final waitlistSortingStrings = {
  WaitlistSorting.date_added: {
    'title': 'Date Added',
    WaitlistSortingDirection.asc: 'New to Old',
    WaitlistSortingDirection.desc: 'Old to New',
  },
  WaitlistSorting.price: {
    'title': 'Price',
    WaitlistSortingDirection.asc: 'High to Low',
    WaitlistSortingDirection.desc: 'Low to High',
  },
  WaitlistSorting.price_cut: {
    'title': 'Discount',
    WaitlistSortingDirection.asc: 'High to Low',
    WaitlistSortingDirection.desc: 'Low to High',
  },
  WaitlistSorting.title: {
    'title': 'Title',
    WaitlistSortingDirection.asc: 'A to Z',
    WaitlistSortingDirection.desc: 'Z to A',
  },
};
