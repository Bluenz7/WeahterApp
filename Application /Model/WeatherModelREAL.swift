//
//  WeatherModelREAL.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 22.05.2025.
//

import Foundation
import UIKit


enum SectionIdentifier: Hashable {
    case custom(CollectionCellSection)
}


struct CollectionCellModel: Hashable {
    var section: [CollectionCellSection]
}

struct CollectionCellSection: Hashable {
    var uuid: String = UUID().uuidString
    var item: [CollectionCellItem]
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

extension CollectionCellSection: Equatable {
    static func == (lhs: CollectionCellSection, rhs: CollectionCellSection) -> Bool {
        lhs.uuid == rhs.uuid
    }
}

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
