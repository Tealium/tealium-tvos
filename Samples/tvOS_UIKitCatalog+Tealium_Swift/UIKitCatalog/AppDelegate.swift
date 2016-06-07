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
    func application(app: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        print("Application launched with URL: \(url)")
        return true
    }
    
    func applicationDidFinishLaunching(application: UIApplication) {
        
        TealiumHelper.startTracking()
        
        TealiumHelper.trackEvent("launch", dataSources: ["autotracked":"false"])
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
        TealiumHelper.trackEvent("sleep", dataSources: ["autotracked":"false"])
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
     
        TealiumHelper.trackEvent("wake", dataSources: ["autotracked":"false"])

    }

}
