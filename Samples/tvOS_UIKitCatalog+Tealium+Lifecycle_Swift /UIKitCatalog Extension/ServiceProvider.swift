/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A class that conforms to the `TVTopShelfProvider` protocol. The Top Shelf extension uses this class to query for items to show.
*/

import TVServices

class ServiceProvider: NSObject, TVTopShelfProvider {
    // MARK: TVTopShelfProvider
    
    /**
        The style of Top Shelf items to show.
        Modify this property to view different styles.
    */
    let topShelfStyle: TVTopShelfContentStyle = .sectioned
    
    var topShelfItems: [TVContentItem] {
        switch topShelfStyle {
            case .sectioned:
                return sectionedTopShelfItems
                
            case .inset:
                return insetTopShelfItems
        }
    }
    
    // MARK: Convenience
    
    /// An array of `TVContentItem`s to show when `topShelfStyle` returns `.Sectioned`.
    fileprivate var sectionedTopShelfItems: [TVContentItem] {
        /*
            Limit the items we show to the first 2 items in the `Iceland` and
            `Lola` groups.
        */
        let dataItemSections: [(DataItem.Group, [DataItem])] = [DataItem.Group.Iceland, DataItem.Group.Lola].map { group in
            let currentGroupItems = DataItem.sampleItems.filter { $0.group == group }
            let itemsToDisplay = Array(currentGroupItems.prefix(2))
            
            return (group, itemsToDisplay)
        }
        
        let sectionContentItems: [TVContentItem] = dataItemSections.map { group, dataItems in
            /*
                Create an array of `TVContentItem`s for each `DataItem` in the
                current array of items.
            */
            let contentItems: [TVContentItem] = dataItems.map { dataItem in
                guard let imageURL = Bundle.main.url(forResource: dataItem.imageName, withExtension: nil) else { fatalError("Error determining local image URL.") }
                
                let contentItem = contentItemWithDataItem(dataItem)
                contentItem.imageURL = imageURL
                contentItem.imageShape = .square
                
                return contentItem
            }
            
            // Create a `TVContentItem` to group the `TVContentItem`s into a section.
            let sectionIdentifier = TVContentIdentifier(identifier: group.rawValue, container: nil)
            let sectionItem = TVContentItem(contentIdentifier: sectionIdentifier)
            
            sectionItem.title = group.rawValue
            sectionItem.topShelfItems = contentItems
            
            return sectionItem
        }
        
        return sectionContentItems
    }
    
    /// An array of `TVContentItem`s to show when `topShelfStyle` returns `.Inset`.
    fileprivate var insetTopShelfItems: [TVContentItem] {
        // Limit the items we show to the first 4 items in the `Lola` group.
        let lolaItems = DataItem.sampleItems.filter { $0.group == .Lola }
        let itemsToDisplay = Array(lolaItems.prefix(4))
        
        // Create an array of `TVContentItem`s for each `DataItem` in the array.
        let contentItems: [TVContentItem] = itemsToDisplay.map { dataItem in
            guard let imageURL = Bundle.main.url(forResource: dataItem.largeImageName, withExtension: nil) else { fatalError("Error determining local image URL.") }

            let contentItem = contentItemWithDataItem(dataItem)
            contentItem.imageURL = imageURL
            contentItem.imageShape = .extraWide
            
            return contentItem
        }
    
        return contentItems
    }

    /// Returns a `TVContentItem` for a `DataItem`.
    fileprivate func contentItemWithDataItem(_ dataItem: DataItem) -> TVContentItem {
        let contentIdentifier = TVContentIdentifier(identifier: dataItem.identifier, container: nil)
        let contentItem = TVContentItem(contentIdentifier: contentIdentifier)
        
        contentItem.title = dataItem.title
        contentItem.displayURL = dataItem.displayURL as URL
        
        return contentItem
    }
}

