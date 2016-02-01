/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    An extension of `DataItem` that provides a static array of sample `DataItem`s.
*/

import Foundation

extension DataItem {
    /// A static sample set of `DataItem`s.
    static var sampleItems: [DataItem] = {
        return Group.allGroups.flatMap { group -> [DataItem] in
            let itemCount: Int

            switch group {
                case .Scenery:
                    itemCount = 6
                    
                case .Iceland:
                    itemCount = 8
                    
                case .Lola:
                    itemCount = 4
                    
                case .Baby:
                    itemCount = 8
            }

            return (1...itemCount).map { DataItem(group: group, number: $0) }
        }
    }()
}
