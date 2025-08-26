//
//  File.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 13.07.2025.
//

import Foundation
import UIKit

final class CustomTabBarView: UIView {
    
    // MARK: - Public callbacks.
    
    var onItemSelected: ((Int) -> Void)?
    
  // MARK: - Private UI.
    
    private let stackView = UIStackView()
    private let buttons: [UIButton] = [
        CustomTabBarView.makeTabButton(title: "", imageName: "cloud.sun"),
        CustomTabBarView.makeTabButton(title: "", imageName: "house")
    ]
    
    private func stupeView() {
        backgroundColor = UIColor(red: 70/255, green: 100/255, blue: 180/255, alpha: 1.0)
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        
        buttons.enumerated().forEach { index, button in
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        addSubview(stackView)
    }
    
    // MARK: - Life Cycle.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func buttonTapped( _ sender: UIButton) {
        onItemSelected?(sender.tag)
        highlightButton(at: sender.tag)
    }
    
    func highlightButton(at index: Int) {
        for(i, btn) in buttons.enumerated() {
            btn.tintColor = i == index ? .white: UIColor.white.withAlphaComponent(0.5)
        }
    }
    
    private static func makeTabButton(title: String, imageName: String) -> UIButton {
        let btn = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let image = UIImage(systemName: imageName, withConfiguration: config)
        
        btn.setImage(image, for: .normal)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.tintColor = UIColor.white.withAlphaComponent(0.5)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.contentVerticalAlignment = .center
        btn.contentHorizontalAlignment = .center
        btn.titleEdgeInsets = UIEdgeInsets(top: 28, left: -20, bottom: 0, right: 0)
        btn.imageEdgeInsets = UIEdgeInsets(top: -10, left: 12, bottom: 10, right: 12)
        
        return btn
    }
}
