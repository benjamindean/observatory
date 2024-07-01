const fs = require("fs");
const { Readable } = require("stream");
const sharp = require("sharp");

const imageUrls = [
  "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_deals_page_light.png",
  "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_deals_page.png",
  "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_deals_page_filters.png",
  "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_search_page.png",
  "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_deal_page.png",
  "https://raw.githubusercontent.com/benjamindean/observatory/dev/screenshots/ios/iPhone%2014%20Pro%20Max_deal_page_top.png",
  "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_waitlist_page_filters.png",
  "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_waitlist_page.png",
];

(async function downloadImage() {
  for (let i = 0; i < imageUrls.length; i++) {
    const file = fs.createWriteStream(
      `./src/assets/screenshots/${imageUrls[i]
        .split("/")
        [imageUrls[i].split("/").length - 1].replace(
          "iPhone%2014%20Pro%20Max_",
          ""
        )}`
    );

    const { body } = await fetch(imageUrls[i]);
    const readableStream = Readable.fromWeb(body);

    const transformer = sharp().resize({ width: 800 }).png();

    readableStream.pipe(transformer).pipe(file);
  }
})();
