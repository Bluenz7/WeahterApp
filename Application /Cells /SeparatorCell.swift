//
//  SeparatorCell.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 26.06.2025.
//

import Foundation
import UIKit

class SeparatorCollectionViewCell: UICollectionViewCell {
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        view.layer.cornerRadius = 2
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
/// Set Separator Hidden.
    internal func setSeparatorHidden(_ hidden: Bool) {
            separatorView.isHidden = hidden
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setSeparatorHidden(false)
    }
    
    private func setupCell() {
        addSubview(separatorView)
        setConstraints()
    }

}

extension SeparatorCollectionViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([

            separatorView.topAnchor.constraint(equalTo: topAnchor, constant: -1),
            separatorView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
