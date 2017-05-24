
//  TealiumHelper.swift
//  Blank+Tealium-Swift
//
//  Created by Jason Koo on 11/16/15.
//  Copyright © 2015 Tealium. All rights reserved.
//

/*
*  Using an abstract class like this is the recommended best practice for
*  utilizing analytics or other third party libraries requiring an event
*  trigger with optional data.
*/
import Foundation
import TealiumTVOS

let tealiumInstanceID = "1"


class TealiumHelper : NSObject {
    
    static let _sharedInstance = TealiumHelper()
    
    class func sharedInstance() -> TealiumHelper{
        
        return _sharedInstance
    }
    
    class func startTracking() {
        
        let config = TEALConfiguration.init(account: "tealiummobile",
                                            profile: "demo",
                                            environment: "dev",
                                            datasource: "testDatasourceId")
                
        let tealium = Tealium.newInstance(forKey: tealiumInstanceID, configuration: config)
        
        tealium.setDelegate(sharedInstance())
        
        self.incrementLifetimeValue(tealium: tealium, key: "launches", value: 1)
        
    }
    
    class func trackEvent(title: String, dataSources: [String:String]){
        
        Tealium.instance(forKey: tealiumInstanceID)?.trackEvent(withTitle: title, dataSources: dataSources)
        
    }
    
    class func trackView(title: String, dataSources: [String:String]){
        
        Tealium.instance(forKey: tealiumInstanceID)?.trackView(withTitle: title, dataSources: dataSources)
        
    }
    
    class func trackType(_ eventType: TEALDispatchType, title: String , dataSources: [String: AnyObject]?, completion: @escaping TEALDispatchBlock) {
        
        Tealium.instance(forKey: tealiumInstanceID)?.trackType(eventType, title: title, dataSources: dataSources!, completion: completion)
        
    }
    
    class func stopTracking(){
        
        Tealium.destroyInstance(forKey: tealiumInstanceID)
        
    }
}

extension TealiumHelper : TealiumDelegate {
    
    @nonobjc func tealium(_ shouldDroptealium: Tealium!, shouldDropDispatch dispatch: TEALDispatch!) -> Bool {
        
        // Add optional tracking suppression logic here - returning true will destroy
        // any processed dispatch so some conditional must eventually return false
        
        return false
    }
    
    func tealium(_ tealium: Tealium!, shouldQueue dispatch: TEALDispatch!) -> Bool {
        
        // Add optional queuing / saving logic here - returning true will save
        // a dispatch so some condition must eventually return false.
        
        return false
    }
    
    func tealium(_ tealium: Tealium!, didQueue dispatch: TEALDispatch!) {
        
        print("Did queue dispatch: \(dispatch)")
        
        // Add optional code here to respond to queuing of dispatches.

    }
    
    func tealium(_ tealium: Tealium!, didSend dispatch: TEALDispatch!) {
        
        print("Did send dispatch: \(dispatch)")
        
        // Add optional code here to respond to sent dispatches.

    }
    
    func tealium(_ tealium: Tealium!, webViewIsReady webView: Any!) {

        // Use this to interact with the Tag Management Dispatcher's webview - available only if Tag Management enabled via remote settings.

        
    }
}

// MARK: Example Methods using other Tealium APIs
extension TealiumHelper{
    
    //WARNING: not persisting
    
    class func incrementLifetimeValue(tealium: Tealium, key: String, value: Int) {
        
        var oldNumber = 0
        
        let persistentData = tealium.persistentDataSourcesCopy()
        
        if let savedNumber = (persistentData[key] as AnyObject).integerValue {
            
            oldNumber = savedNumber
            
        }
        
        let newNumber = oldNumber + value
        
        let newNumberString = NSString(format: "%i", newNumber)
        
        tealium.addPersistentDataSources([key:newNumberString])
        
        print("Current lifetime value for \(key) is \(newNumber)")
        
        
    }
    
}
