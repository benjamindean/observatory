import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:observatory/settings/settings_repository.dart';
import 'package:observatory/shared/api/api.dart';
import 'package:observatory/shared/models/deal.dart';
import 'package:observatory/shared/models/price.dart';
import 'package:observatory/shared/models/shop.dart';
import 'package:observatory/waitlist/providers/waitlist_provider.dart';

final List<Deal> waitlist = [
  const Deal(
    id: '018d937f-505a-7386-b1c4-42986a89ec79',
    title: 'GNOSIA',
    type: 'game',
    slug: 'gnosia',
    prices: [
      Price(
        cut: 0.0,
        drm: [
          DRM(id: 1, name: 'Steam'),
        ],
        price: PriceDetails(
          amount: 24.99,
          amountInt: 24,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 24.99,
          amountInt: 24,
          currency: 'USD',
        ),
        shop: Shop(id: 63, name: 'Steam'),
      ),
    ],
  ),
  const Deal(
    id: '018d937f-506e-72eb-975a-1a5175b622de',
    title: 'Lies Of P',
    type: 'game',
    slug: 'lies-of-p',
    prices: [
      Price(
        cut: 30.0,
        drm: [
          DRM(id: 1, name: 'Steam'),
        ],
        price: PriceDetails(
          amount: 41.99,
          amountInt: 41,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 41.99,
          amountInt: 41,
          currency: 'USD',
        ),
        shop: Shop(id: 63, name: 'Steam'),
      ),
      Price(
        cut: 17.0,
        drm: [
          DRM(id: 2, name: 'Steam'),
        ],
        voucher: 'OMEN17',
        price: PriceDetails(
          amount: 49.79,
          amountInt: 49,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 49.79,
          amountInt: 49,
          currency: 'USD',
        ),
        shop: Shop(id: 63, name: 'Fanatical'),
      ),
      Price(
        cut: 0.0,
        drm: [
          DRM(id: 3, name: 'Microsoft Store'),
        ],
        price: PriceDetails(
          amount: 59.99,
          amountInt: 59,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 59.99,
          amountInt: 59,
          currency: 'USD',
        ),
        shop: Shop(id: 63, name: 'Microsoft Store'),
      ),
      Price(
        cut: 0.0,
        drm: [
          DRM(id: 3, name: 'Steam'),
        ],
        price: PriceDetails(
          amount: 59.99,
          amountInt: 59,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 59.99,
          amountInt: 59,
          currency: 'USD',
        ),
        shop: Shop(id: 66, name: 'Humble Store'),
      ),
      Price(
        cut: 0.0,
        drm: [
          DRM(id: 3, name: 'Steam'),
        ],
        price: PriceDetails(
          amount: 59.99,
          amountInt: 59,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 59.99,
          amountInt: 59,
          currency: 'USD',
        ),
        shop: Shop(id: 67, name: 'GreenManGaming'),
      ),
    ],
  ),
  const Deal(
    id: '018d937f-1ea1-732d-ab65-d3fc078354b3',
    title: 'Danganronpa 2: Goodbye Despair',
    type: 'game',
    slug: 'danganronpa-2-goodbye-despair',
    prices: [
      Price(
        cut: 0.0,
        drm: [
          DRM(id: 3, name: 'Steam'),
        ],
        price: PriceDetails(
          amount: 19.99,
          amountInt: 19,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 19.99,
          amountInt: 19,
          currency: 'USD',
        ),
        shop: Shop(id: 66, name: 'Humble Store'),
      ),
      Price(
        cut: 0.0,
        drm: [
          DRM(id: 3, name: 'Steam'),
        ],
        price: PriceDetails(
          amount: 19.99,
          amountInt: 19,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 19.99,
          amountInt: 19,
          currency: 'USD',
        ),
        shop: Shop(id: 1, name: 'Steam'),
      ),
    ],
  ),
  const Deal(
    id: '018d937f-74ed-71be-8f12-bca1cf5eabe6',
    title: 'Little Goody Two Shoes',
    type: 'game',
    slug: 'little-goody-two-shoes',
    prices: [
      Price(
        cut: 20.0,
        drm: [
          DRM(id: 3, name: 'Steam'),
        ],
        price: PriceDetails(
          amount: 15.99,
          amountInt: 15,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 15.99,
          amountInt: 15,
          currency: 'USD',
        ),
        shop: Shop(id: 66, name: 'GreenManGaming'),
      ),
      Price(
        cut: 20.0,
        drm: [
          DRM(id: 3, name: 'Steam'),
        ],
        price: PriceDetails(
          amount: 15.99,
          amountInt: 15,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 15.99,
          amountInt: 15,
          currency: 'USD',
        ),
        shop: Shop(id: 1, name: 'Humble Store'),
      ),
      Price(
        cut: 11.0,
        drm: [
          DRM(id: 3, name: 'Steam'),
        ],
        price: PriceDetails(
          amount: 17.88,
          amountInt: 17,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 17.88,
          amountInt: 17,
          currency: 'USD',
        ),
        shop: Shop(id: 1, name: 'IndieGala Store'),
      ),
      Price(
        cut: 0.0,
        drm: [
          DRM(id: 3, name: 'Steam'),
        ],
        price: PriceDetails(
          amount: 19.99,
          amountInt: 19,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 19.99,
          amountInt: 19,
          currency: 'USD',
        ),
        shop: Shop(id: 1, name: 'Steam'),
      ),
    ],
  ),
  const Deal(
    id: '018d937f-636c-72e7-ac79-de13a54877c8',
    slug: 'slay-the-princess',
    type: 'game',
    title: 'Slay the Princess',
    steamId: null,
    prices: [
      Price(
        price: PriceDetails(
          amount: 14.39,
          amountInt: 1439,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 17.99,
          amountInt: 1799,
          currency: 'USD',
        ),
        cut: 20.0,
        shop: Shop(
          id: 61,
          name: 'Steam',
        ),
        drm: [],
        url: 'https://itad.link/018d9386-cb20-727a-9d0d-2ea25e9fde79/',
        voucher: null,
        timestamp: '2024-03-25T18:18:30+01:00',
      ),
    ],
    info: null,
    overview: null,
    isLoading: false,
    added: 0,
    source: DealSource.itad,
  ),
  const Deal(
    id: '018d937f-590c-728b-ac35-38bcff85f086',
    slug: 'elden-ring',
    type: 'game',
    title: 'Elden Ring',
    steamId: null,
    prices: [
      Price(
        price: PriceDetails(
          amount: 52.23,
          amountInt: 5223,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 59.99,
          amountInt: 5999,
          currency: 'USD',
        ),
        cut: 13.0,
        shop: Shop(
          id: 20,
          name: 'GameBillet',
        ),
        drm: [DRM(id: 61, name: 'Steam')],
        url: ' https://itad.link/018d9386-5634-71ca-ac17-8fff3f127b84/',
        voucher: null,
        timestamp: '2024-02-28T15:06:18+01:00',
      ),
    ],
    info: null,
    overview: null,
    isLoading: false,
    added: 0,
    source: DealSource.itad,
  ),
  const Deal(
    id: '018d937e-fda5-726b-837e-0baaa34c7519',
    slug: 'lisa-complete-edition',
    type: 'dlc',
    title: 'LISA: Complete Edition',
    steamId: null,
    prices: [
      Price(
        price: PriceDetails(
          amount: 26.24,
          amountInt: 2624,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 34.99,
          amountInt: 3499,
          currency: 'USD',
        ),
        cut: 25.0,
        shop: Shop(
          id: 61,
          name: 'Steam',
        ),
        drm: [DRM(id: 61, name: 'Steam')],
        url: 'https://itad.link/018d9386-8d27-715f-89f5-3d82ed507bbd/',
        voucher: null,
        timestamp: '2024-03-22T17:15:14+01:00',
      )
    ],
    info: null,
    overview: null,
    isLoading: false,
    added: 0,
    source: DealSource.itad,
  ),
  const Deal(
    id: '018d937f-138d-724f-82bb-f180b2ea819a',
    slug: 'katana-zero',
    type: 'game',
    title: 'Katana ZERO',
    steamId: null,
    prices: [
      Price(
        price: PriceDetails(
          amount: 8.99,
          amountInt: 899,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 14.99,
          amountInt: 1499,
          currency: 'USD',
        ),
        cut: 40.0,
        shop: Shop(
          id: 35,
          name: 'GOG',
        ),
        drm: [DRM(id: 1000, name: 'Drm Free')],
        url: ' https://itad.link/018d9386-8560-7202-bdc7-7f4b18d43fa8/',
        voucher: null,
        timestamp: ' 2024-03-19T14:51:44+01:00',
      ),
    ],
    info: null,
    overview: null,
    isLoading: false,
    added: 0,
    source: DealSource.itad,
  ),
  const Deal(
    id: '018d937f-4382-707a-85b5-cdf1984ea8a8',
    slug: 'persona-4-golden',
    type: 'game',
    title: 'Persona 4 Golden',
    steamId: null,
    prices: [
      Price(
        price: PriceDetails(
          amount: 16.39,
          amountInt: 1639,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 19.99,
          amountInt: 1999,
          currency: 'USD',
        ),
        cut: 18.0,
        shop: Shop(
          id: 20,
          name: 'GameBillet',
        ),
        drm: [DRM(id: 61, name: 'Steam')],
        url: 'https://itad.link/018d9386-ab6b-7286-b947-4631a252d9a7/',
        voucher: null,
        timestamp: '2024-02-20T01:21:20+01:00',
      ),
    ],
    info: null,
    overview: null,
    isLoading: false,
    added: 0,
    source: DealSource.itad,
  ),
  const Deal(
    id: '018d937f-6140-7026-95d4-1dfca6fd8599',
    slug: '',
    type: 'game',
    title: 'ANIMAL WELL',
    steamId: null,
    prices: [
      Price(
        price: PriceDetails(
          amount: 24.99,
          amountInt: 2499,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 24.99,
          amountInt: 2499,
          currency: 'USD',
        ),
        cut: 0.0,
        shop: Shop(id: 61, name: 'Steam'),
        drm: [],
        url: 'https://itad.link/018f5d7e-6b40-72ab-82a7-06f150c0a246/',
        voucher: null,
        timestamp: '2024-05-23T19:15:19+02:00',
      )
    ],
    info: null,
    overview: null,
    isLoading: false,
    added: 1716465068207,
    source: DealSource.itad,
  ),
  const Deal(
    id: '018d937f-400f-7048-8e09-1475bfbd1fd8',
    slug: '',
    type: 'game',
    title: 'Saturnalia',
    steamId: null,
    prices: [
      Price(
        price: PriceDetails(
          amount: 8.99,
          amountInt: 899,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 19.99,
          amountInt: 1999,
          currency: 'USD',
        ),
        cut: 55.0,
        shop: Shop(id: 16, name: 'Epic Game Store'),
        drm: [DRM(id: 16, name: 'Epic')],
        url: 'https://itad.link/018d959d-63ff-71f1-81a2-53c3d649bd44/',
        voucher: null,
        timestamp: '2024-05-16T18:31:01+02:00',
      ),
      Price(
        price: PriceDetails(
          amount: 16.59,
          amountInt: 1659,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 19.99,
          amountInt: 1999,
          currency: 'USD',
        ),
        cut: 17.0,
        shop: Shop(id: 6, name: 'Fanatical'),
        drm: [DRM(id: 61, name: 'Steam')],
        url: 'https://itad.link/018ea9a5-2f30-7305-8859-de6841975b57/',
        voucher: 'OMEN17',
        timestamp: '2024-04-04T17:06:01+02:00',
      ),
      Price(
        price: PriceDetails(
          amount: 19.99,
          amountInt: 1999,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 19.99,
          amountInt: 1999,
          currency: 'USD',
        ),
        cut: 0.0,
        shop: Shop(id: 37, name: 'Humble Store'),
        drm: [DRM(id: 61, name: 'Steam')],
        url: 'https://itad.link/018f3c3d-ade5-700b-855a-821684353501/',
        voucher: null,
        timestamp: '2024-05-03T04:17:06+02:00',
      ),
      Price(
        price: PriceDetails(
          amount: 19.99,
          amountInt: 1999,
          currency: 'USD',
        ),
        regular: PriceDetails(
          amount: 19.99,
          amountInt: 1999,
          currency: 'USD',
        ),
        cut: 0.0,
        shop: Shop(id: 61, name: 'Steam'),
        drm: [],
        url: 'https://itad.link/018d9386-c0e0-709c-b62e-b597f09f033f/',
        voucher: null,
        timestamp: '2024-05-16T19:18:24+02:00',
      )
    ],
    info: null,
    overview: null,
    isLoading: false,
    added: 1690555884000,
    source: DealSource.steam,
  ),
];

class AsyncWaitListNotifierMock extends AsyncNotifier<List<Deal>>
    with Mock
    implements AsyncWaitListNotifier {
  @override
  final SettingsRepository settingsRepository = GetIt.I<SettingsRepository>();
  @override
  final API api = GetIt.I<API>();

  Future<List<Deal>> _fetchWaitList() async {
    return waitlist;
  }

  @override
  Future<List<Deal>> build() async {
    return _fetchWaitList();
  }

  @override
  Future<void> reset({bool withLoading = false}) async {
    state = await AsyncValue.guard(() => _fetchWaitList());
  }

  @override
  Future<void> addToWaitlist(Deal deal) async {
    state = state;
  }

  @override
  Future<void> removeFromWaitList(Deal deal) async {
    state = state;
  }

  @override
  Future<void> clearWaitlist() async {
    state = state;
  }
}
