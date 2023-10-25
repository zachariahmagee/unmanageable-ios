//
//  Item.swift
//  unManageable
//
//  Created by Zachariah Magee on 10/25/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
