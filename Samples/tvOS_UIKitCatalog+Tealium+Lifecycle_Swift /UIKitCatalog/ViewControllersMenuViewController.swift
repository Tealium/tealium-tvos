/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The `MenuTableViewController` subclass for the "View Controllers" section of the app.
*/

import UIKit

class ViewControllersMenuViewController: MenuTableViewController {
    // MARK: Properties
    
    override var segueIdentifierMap: [[String]] {
        return [
            [
                "ShowAlertControllers",
                "ShowCollectionViewController",
                "ShowPageViewController",
                "ShowSearchViewController"
            ]
        ]
    }
}
