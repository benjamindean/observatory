import React from "react";
import HeroBlock from "../components/hero-block.tsx";

export default function Main() {
  return (
    <>
      <HeroBlock
        title="Observatory - Game Discounts"
        subtitle={[
          <p>
            Tired of waiting for the next big sale? Observatory has you covered.
          </p>,
          <br></br>,
          <p>
            Observatory is the essential app for tracking PC game prices and
            discounts exclusively from legitimate resellers. Easily monitor the
            best deals for your favorite PC games, ensuring you never miss out
            on a sale.
          </p>,
        ]}
        imageUrls={[
          "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_deals_page_light.png",
          "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_deals_page.png",
        ]}
        reversed
        backgroundTint="bg-red-200"
        bottom={
          <>
            <a
              href="https://apps.apple.com/app/observatory-for-itad/id6479194330"
              target="_blank"
            >
              <img src="./images/appstore-button.pmng" />
            </a>
          </>
        }
      />

      <div className="flex stats stats-vertical lg:stats-horizontal container mx-auto px-4">
        <div className="stat place-items-center">
          <div className="stat-title">More Than</div>
          <div className="stat-value">200k</div>
          <div className="stat-title">Games</div>
        </div>

        <div className="stat place-items-center">
          <div className="stat-title">Over</div>
          <div className="stat-value">30</div>
          <div className="stat-title">Legitimate Resellers</div>
        </div>

        <div className="stat place-items-center">
          <div className="stat-title">Choose From</div>
          <div className="stat-value">Over 40</div>
          <div className="stat-title">Colorful Themes</div>
        </div>
      </div>

      <HeroBlock
        title="Discover Game Deals From Over 30 Legitimate Resellers"
        subtitle={[
          <p>
            <strong>No account</strong>. <strong>No ads.</strong>{" "}
            <strong>No tracking</strong>. Just the best deals from the most
            popular resellers like Fanatical, GreenManGaming, IndieGala Store,
            and many more!
          </p>,
        ]}
        imageUrls={[
          "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_deals_page_filters.png",
          "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_search_page.png",
        ]}
        backgroundTint="bg-sky-300"
      />

      <HeroBlock
        title="Get detailed information and compare prices"
        subtitle={[
          <p>
            Easily access comprehensive game details and compare prices from
            multiple resellers to find the best deals.
          </p>,
        ]}
        imageUrls={[
          "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_deal_page.png",
          "https://raw.githubusercontent.com/benjamindean/observatory/dev/screenshots/ios/iPhone%2014%20Pro%20Max_deal_page_top.png",
        ]}
        reversed
        backgroundTint="bg-emerald-300	"
      />

      <HeroBlock
        title="Track game prices with the Waitlist"
        subtitle={[
          <p>
            Add your favorite games to the waitlist and{" "}
            <strong>receive notifications</strong> when a price drop happens.
          </p>,
          <br></br>,
          <p>You can also import your Wishlist from Steam.</p>,
        ]}
        imageUrls={[
          "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_waitlist_page_filters.png",
          "https://raw.githubusercontent.com/benjamindean/observatory/main/screenshots/ios/iPhone%2014%20Pro%20Max_waitlist_page.png",
        ]}
        backgroundTint="bg-zinc-200"
      />

      <article className="prose max-w-6xl container mx-auto py-8 px-8">
        <h2 className="text-center">FAQ</h2>
        <p>
          <strong>Q:</strong> Why does the discount in the app not match the
          discount at the store?
          <br></br>
          <strong>A:</strong> It probably means that the data about prices is
          not updated on{" "}
          <a href="https://isthereanydeal.com">IsThereAnyDeal.com</a> yet. The
          data is aggregated in multiple currencies from a lot of stores, so
          some delays are to be expected. This also applies to coupons, bundles,
          and review scores.
        </p>
        <p>
          <strong>Q:</strong> The app is taking a long time to load and/or
          crashes. Do I have to submit a bug report?
          <br></br>
          <strong>A:</strong> Sometimes there is a high load on the servers due
          to some major sales. There also might be maintenance going on. You can
          always check{" "}
          <a href="https://isthereanydeal.com">IsThereAnyDeal.com</a> and if
          it's working as expected, please report a bug here.
        </p>
        <p>
          <strong>Q:</strong> Will these keys get my Steam account blocked?
          <br></br>
          <strong>A:</strong> No, all the stores within the app are legitimate
          key resellers, so there should be no "grey" keys whatsoever.
        </p>
      </article>

      <article className="prose max-w-6xl container mx-auto py-8 px-8">
        <h2 className="text-center">Disclaimer</h2>
        <p>
          All the data about prices, stores, coupons, review scores and
          discounts is provided by{" "}
          <a href="https://isthereanydeal.com">IsThereAnyDeal.com</a>.
          Observatory is not affiliated with{" "}
          <a href="https://isthereanydeal.com">IsThereAnyDeal.com</a> in any
          way.
        </p>
      </article>
    </>
  );
}
