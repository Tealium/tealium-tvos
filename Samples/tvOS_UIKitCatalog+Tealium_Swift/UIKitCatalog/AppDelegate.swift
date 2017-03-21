/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The application-specific delegate class.
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /*
        When the user clicks a Top Shelf item, the application will be asked
        to open the associated URL.
    */
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        print("Application launched with URL: \(url)")
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        TealiumHelper.startTracking()
                
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        TealiumHelper.trackEvent(title: "sleep", dataSources: [:])
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        TealiumHelper.trackEvent(title: "wake", dataSources: [:])
        
    }
}
