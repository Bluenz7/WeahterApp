//
//  HeaderSupplementaryView.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 20.05.2025.
//

import Foundation
import UIKit

class HeaderSupplementaryView: UICollectionReusableView {
    
    // MARK: - Private Properties.
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.alpha = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Extension Configuration.

extension HeaderSupplementaryView {
    func configureHeader(categoryName: String) {
        headerLabel.text = categoryName
    }
}

// MARK: - Extension Setup of View

extension HeaderSupplementaryView {
    func setup() {
        setupView()
        setConstraints()
    }
    
    func setupView() {
        addSubview(headerLabel)
        addSubview(separatorView)
    }
// MARK: - Set Constraints.
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            separatorView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 6),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}
