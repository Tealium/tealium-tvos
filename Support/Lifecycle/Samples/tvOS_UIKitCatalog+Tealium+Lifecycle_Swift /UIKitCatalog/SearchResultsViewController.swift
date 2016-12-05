/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A `UICollectionViewController` subclass that is used to show `DataItem` search results for the `UISearchController` shown by `SearchViewController`.
*/

import UIKit

class SearchResultsViewController: UICollectionViewController, UISearchResultsUpdating {
    // MARK: Properties
    
    static let storyboardIdentifier = "SearchResultsViewController"

    fileprivate let cellComposer = DataItemCellComposer()

    fileprivate let allDataItems = DataItem.sampleItems
    
    fileprivate var filteredDataItems = DataItem.sampleItems
    
    var filterString = "" {
        didSet {
            // Return if the filter string hasn't changed.
            guard filterString != oldValue else { return }

            // Apply the filter or show all items if the filter string is empty.
            if filterString.isEmpty {
                filteredDataItems = allDataItems
            }
            else {
                filteredDataItems = allDataItems.filter { $0.title.localizedStandardContains(filterString) }
            }
            
            // Reload the collection view to reflect the changes.
            collectionView?.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredDataItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue a cell from the collection view.
        return collectionView.dequeueReusableCell(withReuseIdentifier: DataItemCollectionViewCell.reuseIdentifier, for: indexPath)
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? DataItemCollectionViewCell else { fatalError("Expected to display a `DataItemCollectionViewCell`.") }
        let item = filteredDataItems[indexPath.row]
        
        // Configure the cell.
        cellComposer.composeCell(cell, withDataItem: item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        filterString = searchController.searchBar.text ?? ""
    }
}
