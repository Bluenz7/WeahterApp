//
//  CollectionCellItems.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 03.06.2025.
//

import Foundation
import UIKit


struct CollectionModel {
    var sections: [CollectionSection]
}

struct CollectionSection {
//    var uuid: String = UUID().uuidString
    var items: [CollectionItem]
    var title: String
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(uuid)
//    }
}

//extension CollectionCellSection: Equatable {
//    static func == (lhs: CollectionCellSection, rhs: CollectionCellSection) -> Bool {
//        lhs.uuid == rhs.uuid
//    }
//}
struct CollectionItem {
//    var uuid: String = UUID().uuidString
    var cellType: UICollectionViewCell.Type
    var cellModel: Any
    var id: String {
        String(describing: cellType.self)
    }
    
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(uuid)
//    }
}

//extension CollectionCellItem: Equatable {
//    static func == (lhs: CollectionCellItem, rhs: CollectionCellItem) -> Bool {
//        lhs.uuid == rhs.uuid
//    }
//}
