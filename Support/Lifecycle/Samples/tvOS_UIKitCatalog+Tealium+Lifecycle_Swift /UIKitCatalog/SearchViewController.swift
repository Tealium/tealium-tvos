/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to present a `UISearchController`. The search results are shown in an instance of `SearchResultsViewController`.
*/

import UIKit

class SearchViewController: UIViewController, UISearchControllerDelegate {
    
    @IBAction func showSearchController(_ sender: AnyObject) {
        /*
            Instantiate an instance of a `SearchResultsViewController` from the
            storyboard. This will be used by the `UISearchController` to display
            search results.
        */
        guard let resultsController = storyboard?.instantiateViewController(withIdentifier: SearchResultsViewController.storyboardIdentifier) as? SearchResultsViewController else { fatalError("Unable to instantiate a SearchResultsViewController.") }
        
        // Create and configure a `UISearchController`.
        let searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = resultsController
        searchController.hidesNavigationBarDuringPresentation = false

        let searchPlaceholderText = NSLocalizedString("Enter keyword (e.g. iceland)", comment: "")
        searchController.searchBar.placeholder = searchPlaceholderText
     
        // Present the search controller from the containing split view.
        splitViewController?.present(searchController, animated: true, completion: nil)
    }
}
