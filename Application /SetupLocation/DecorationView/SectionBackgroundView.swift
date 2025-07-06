//
//  SectionBackgroundView.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 27.05.2025.
//

import Foundation
import UIKit

final class SectionBackgroundView: UICollectionReusableView {
    static let elementKind = "SectionBackgroundView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
