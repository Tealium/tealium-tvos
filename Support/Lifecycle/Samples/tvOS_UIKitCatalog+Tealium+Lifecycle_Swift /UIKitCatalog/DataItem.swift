/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A struct used throughout the sample to represent example data.
*/

import Foundation

struct DataItem: Equatable {
    // MARK: Types
    
    enum Group: String {
        case Scenery
        case Iceland
        case Lola
        case Baby
        
        static let allGroups: [Group] = [.Scenery, .Iceland, .Lola, .Baby]
    }
    
    // MARK: Properties
    
    let group: Group
    
    let number: Int
    
    var title: String {
        return "\(group.rawValue)"
    }
    
    var identifier: String {
        return "\(group.rawValue).\(number)"
    }
    
    var displayURL: URL {
        var components = URLComponents()
        components.scheme = "uikitcatalog"
        components.path = "dataItem"
        components.queryItems = [URLQueryItem(name: "identifier", value: identifier)]
        
        return components.url!
    }
    
    // MARK: Convenience
    
    /// A static `NSNumberFormatter` used to create a localized title for the `DataItem`.
    fileprivate static var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter
    }()
}

// MARK: Equatable

func ==(lhs: DataItem, rhs: DataItem)-> Bool {
    // Two `DataItem`s are considered equal if their identifiers match.
    return lhs.identifier == rhs.identifier
}
