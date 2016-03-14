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
    let topShelfStyle: TVTopShelfContentStyle = .Sectioned
    
    var topShelfItems: [TVContentItem] {
        switch topShelfStyle {
            case .Sectioned:
                return sectionedTopShelfItems
                
            case .Inset:
                return insetTopShelfItems
        }
    }
    
    // MARK: Convenience
    
    /// An array of `TVContentItem`s to show when `topShelfStyle` returns `.Sectioned`.
    private var sectionedTopShelfItems: [TVContentItem] {
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
                guard let imageURL = NSBundle.mainBundle().URLForResource(dataItem.imageName, withExtension: nil) else { fatalError("Error determining local image URL.") }
                
                let contentItem = contentItemWithDataItem(dataItem)
                contentItem.imageURL = imageURL
                contentItem.imageShape = .Square
                
                return contentItem
            }
            
            // Create a `TVContentItem` to group the `TVContentItem`s into a section.
            guard let sectionIdentifier = TVContentIdentifier(identifier: group.rawValue, container: nil) else { fatalError("Error creating content identifier for section item.") }
            guard let sectionItem = TVContentItem(contentIdentifier: sectionIdentifier) else { fatalError("Error creating section content item.") }
            
            sectionItem.title = group.rawValue
            sectionItem.topShelfItems = contentItems
            
            return sectionItem
        }
        
        return sectionContentItems
    }
    
    /// An array of `TVContentItem`s to show when `topShelfStyle` returns `.Inset`.
    private var insetTopShelfItems: [TVContentItem] {
        // Limit the items we show to the first 4 items in the `Lola` group.
        let lolaItems = DataItem.sampleItems.filter { $0.group == .Lola }
        let itemsToDisplay = Array(lolaItems.prefix(4))
        
        // Create an array of `TVContentItem`s for each `DataItem` in the array.
        let contentItems: [TVContentItem] = itemsToDisplay.map { dataItem in
            guard let imageURL = NSBundle.mainBundle().URLForResource(dataItem.largeImageName, withExtension: nil) else { fatalError("Error determining local image URL.") }

            let contentItem = contentItemWithDataItem(dataItem)
            contentItem.imageURL = imageURL
            contentItem.imageShape = .ExtraWide
            
            return contentItem
        }
    
        return contentItems
    }

    /// Returns a `TVContentItem` for a `DataItem`.
    private func contentItemWithDataItem(dataItem: DataItem) -> TVContentItem {
        guard let contentIdentifier = TVContentIdentifier(identifier: dataItem.identifier, container: nil) else { fatalError("Error creating content identifier.") }
        guard let contentItem = TVContentItem(contentIdentifier: contentIdentifier) else { fatalError("Error creating content item.") }
        
        contentItem.title = dataItem.title
        contentItem.displayURL = dataItem.displayURL
        
        return contentItem
    }
}

