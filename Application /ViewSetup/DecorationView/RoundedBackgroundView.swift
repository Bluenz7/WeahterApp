//
//  RoundedBackgroundView.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 27.05.2025.
//

import Foundation
import UIKit

class RoundedBackgroundView: UICollectionReusableView {
    
    static let elementKind = "RoundedBackgroundView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.secondarySystemBackground
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
