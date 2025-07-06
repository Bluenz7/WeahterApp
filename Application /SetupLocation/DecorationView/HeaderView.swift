//
//  HeaderView.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 27.05.2025.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {

    private let titleLabel = UILabel()
    private var heightConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateProgress(_ progress: CGFloat) {
        // Змінюємо альфу чи масштаб — це і є ефект згортання
        self.titleLabel.alpha = progress
        self.transform = CGAffineTransform(scaleX: 1.0, y: max(0.7, progress))
    }
}
