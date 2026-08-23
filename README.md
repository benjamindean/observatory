<h1 align="center">
   Observatory
</h1>

<p align="center">
    <img src="./assets/icon/observatory.png" alt="alt text" width="120" height="120">
</p>

Observatory is the essential app for tracking PC game prices and discounts exclusively from legitimate resellers. Easily monitor the best deals for your favorite PC games, ensuring you never miss out on a sale.

[<img src="./assets/images/appstore-button.png" height="50px">](https://apps.apple.com/us/app/observatory-for-itad/id6479194330)
[<img src="./assets/images/apk-button.png" height="50px">](https://github.com/benjamindean/observatory/releases/latest)
[<img src="./assets/images/obtainium-button.png" height="50px">]([https://apps.obtainium.imranr.dev/redirect?r=obtainium://app/%7B%22id%22%3A%22com.benjaminabel.observatory%22%2C%22url%22%3A%22https%3A%2F%2Fgithub.com%2Fbenjamindean%2Fobservatory%22%2C%22author%22%3A%22benjamindean%22%2C%22name%22%3A%22Observatory%22%2C%22preferredApkIndex%22%3A0%2C%22additionalSettings%22%3A%22%7B%5C%22includePrereleases%5C%22%3Afalse%2C%5C%22verifyLatestTag%5C%22%3Afalse%2C%5C%22fallbackToOlderReleases%5C%22%3Atrue%2C%5C%22filterReleaseTitlesByRegEx%5C%22%3A%5C%22%5C%22%2C%5C%22filterReleaseNotesByRegEx%5C%22%3A%5C%22%5C%22%2C%5C%22githubBuildVerificationMode%5C%22%3A%5C%22off%5C%22%2C%5C%22sortMethodChoice%5C%22%3A%5C%22date%5C%22%2C%5C%22useLatestAssetDateAsReleaseDate%5C%22%3Afalse%2C%5C%22trackOnly%5C%22%3Afalse%2C%5C%22onDemandOnly%5C%22%3Afalse%2C%5C%22exemptFromBackgroundUpdates%5C%22%3Afalse%2C%5C%22skipUpdateNotifications%5C%22%3Afalse%2C%5C%22versionStringSource%5C%22%3A%5C%22default%5C%22%2C%5C%22versionExtractionRegEx%5C%22%3A%5C%22%5C%22%2C%5C%22matchGroupToUse%5C%22%3A%5C%22%5C%22%2C%5C%22versionDetection%5C%22%3A%5C%22pseudo%5C%22%2C%5C%22apkFilterRegEx%5C%22%3A%5C%22%5C%22%2C%5C%22invertAPKFilter%5C%22%3Afalse%2C%5C%22autoApkFilterByArch%5C%22%3Atrue%2C%5C%22shizukuPretendToBeGooglePlay%5C%22%3Afalse%2C%5C%22allowInsecure%5C%22%3Afalse%2C%5C%22refreshBeforeDownload%5C%22%3Afalse%2C%5C%22includeZips%5C%22%3Afalse%2C%5C%22zippedApkFilterRegEx%5C%22%3A%5C%22%5C%22%2C%5C%22includeTarballs%5C%22%3Afalse%2C%5C%22tarballedApkFilterRegEx%5C%22%3A%5C%22%5C%22%2C%5C%22enforceGitHubAttestations%5C%22%3Afalse%2C%5C%22releaseDateAsVersion%5C%22%3Afalse%2C%5C%22releaseTitleAsVersion%5C%22%3Afalse%2C%5C%22extractVersionFromAssetName%5C%22%3Afalse%2C%5C%22releaseCommitShaAsVersion%5C%22%3Afalse%2C%5C%22useVersionCodeAsOSVersion%5C%22%3Afalse%2C%5C%22lastInstalledTime%5C%22%3A1784641202939%2C%5C%22appName%5C%22%3A%5C%22Observatory%20-%20PC%20Game%20Sales%5C%22%2C%5C%22appAuthor%5C%22%3A%5C%22benjamindean%5C%22%2C%5C%22about%5C%22%3A%5C%22Track%20discounts%20from%2030%2B%20legitimate%20resellers%2C%20powered%20by%20IsThereAnyDeal%5C%22%7D%22%2C%22overrideSource%22%3A%22GitHub%22%7D])

## Screenshots

<p align="middle">
  <img src="./screenshots/ios/iPhone 14 Pro Max_deals_page.png" width="24%" />
  <img src="./screenshots/ios/iPhone 14 Pro Max_deal_page.png" width="24%" />
  <img src="./screenshots/ios/iPhone 14 Pro Max_waitlist_page.png" width="24%" />
  <img src="./screenshots/ios/iPhone 14 Pro Max_search_page.png" width="24%" />
</p>

## Features

- Track discounts from 30+ legitimate resellers.
- Add games to your waitlist.
- Import your wishlist from Steam.
- Search games.
- View store-specific coupons if available.
- Select from 30+ color schemes to customize the app's appearance.

## FAQ

**Q:** Why does the discount in the app not match the discount at the store?  
**A:** It probably means that the data about prices is not updated on [IsThereAnyDeal.com](https://isthereanydeal.com) yet. The data is aggregated in multiple currencies from a lot of stores, so some delays are to be expected. This also applies to coupons, bundles, and review scores.

**Q:** The app is taking a long time to load and/or crashes. Do I have to submit a bug report?  
**A:** Sometimes there is a high load on the servers due to some major sales. There also might be maintenance going on. You can always check [IsThereAnyDeal.com](https://isthereanydeal.com) and if it's working as expected, please report a bug here.

**Q:** Will these keys get my Steam account blocked?  
**A:** No, all the stores within the app are legitimate key resellers, so there should be no "grey" keys whatsoever.

## Contributing

1. Create a file `secrets.env` with the following content:

```env
OBSERVATORY_API_KEY= ...
```

Please request an API key by creating an Issue on GitHub.

2. Follow [Flutter Docs](https://docs.flutter.dev/) to set up the environment and run the app on an emulator or physical device.
3. Create a Pull Request describing your changes.

## Disclaimer 

All the data about prices, stores, coupons, review scores and discounts comes from [IsThereAnyDeal.com](https://isthereanydeal.com). Observatory is not affiliated with [IsThereAnyDeal.com](https://isthereanydeal.com) in any way.

## Support the Development

This app is free and ad-free, and I intend to keep it that way for the foreseeable future. If you enjoy the app, please consider supporting it. Any amount is appreciated.

**Please note that there are no additional features or benefits for supporters.**

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/benjaminabel)
