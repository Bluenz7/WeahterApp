//
//  CollectionCellItems.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 03.06.2025.
//

import Foundation
import UIKit

struct CollectionCellItem: Hashable {
    var uuid: String = UUID().uuidString
    var cellType: UICollectionViewCell.Type
    var cellModel: Any
    var id: String {
        String(describing: cellType.self)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

extension CollectionCellItem: Equatable {
    static func == (lhs: CollectionCellItem, rhs: CollectionCellItem) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
