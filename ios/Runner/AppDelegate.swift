import UIKit
import Flutter
import awesome_notifications
import workmanager
import app_links
import Sentry

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in
        SwiftAwesomeNotificationsPlugin.register(
          with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)
    }

    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
        GeneratedPluginRegistrant.register(with: registry)
    }

    WorkmanagerPlugin.registerPeriodicTask(withIdentifier: "observatory-waitlist-check", frequency: NSNumber(value: 1 * 60 * 60))

    SentrySDK.start { options in
        options.dsn = "https://b6fb45932c8ec85e9391228f15a3a950@o4508086133522432.ingest.de.sentry.io/4508086146891856"
    }

    if let url = AppLinks.shared.getLink(launchOptions: launchOptions) {
      AppLinks.shared.handleLink(url: url)

      return true
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
