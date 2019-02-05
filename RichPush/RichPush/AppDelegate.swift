//
//  AppDelegate.swift
//  RichPush
//
//  Created by Christopher Batin on 05/02/2019.
//  Copyright © 2019 Christopher Batin. All rights reserved.
//

import UIKit
import PushNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let pushNotifications = PushNotifications.shared


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.pushNotifications.start(instanceId: "9f9818f2-67e5-41d3-90ea-53efe135cccc")
        self.pushNotifications.registerForRemoteNotifications()
        try? self.pushNotifications.subscribe(interest: "general")

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.pushNotifications.registerDeviceToken(deviceToken)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.pushNotifications.handleNotification(userInfo: userInfo)
    }

}

