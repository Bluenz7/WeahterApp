//
//  TemperatureGradientBar.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 06.06.2025.
//

import Foundation
import UIKit

class TemperatureGradientBar: UIView {
    
    //MARK: - Private Properties and Methods.
    private let gradientLayer = CAGradientLayer()
    private var indicatorCenterXConstraint: NSLayoutConstraint?
    
    private lazy var imageIndicator: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(red: 20/255, green: 17/255, blue: 40/255, alpha: 1.0)
        image.layer.cornerRadius = 2.5
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 5).isActive = true
        image.heightAnchor.constraint(equalToConstant: 12).isActive = true
        return image
    }()
    
    var temperature: Double = 25 {
        didSet {
            updateGradientColors()
            updateIndicator()
        }
    }
    /// The Initial Gradient.
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemGreen.cgColor,
            UIColor.systemYellow.cgColor,
            UIColor.systemRed.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.6)
        gradientLayer.cornerRadius = 4
        layer.addSublayer(gradientLayer)
    }
    
    private func setupIndicator() {
        addSubview(imageIndicator)
        indicatorCenterXConstraint = imageIndicator.centerXAnchor.constraint(equalTo: leadingAnchor)
        NSLayoutConstraint.activate([
            indicatorCenterXConstraint!,
            imageIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    /// Set Indicator.
    private func updateIndicator() {
        let minTemp: Double = 0
        let maxTemp: Double = 40
        let clampedTemp = min(max(temperature, minTemp), maxTemp)
        
        let ratio = (clampedTemp - minTemp) / (maxTemp - minTemp)
        let newX = bounds.width * CGFloat(ratio)
        
        indicatorCenterXConstraint?.constant = newX
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
    /// Color Temperature.
    private func updateGradientColors() {
        if temperature <= 0 {
            gradientLayer.colors = [
                UIColor.systemBlue.cgColor,
                UIColor.systemCyan.cgColor
            ]
        } else if temperature > 0 && temperature < 18 {
            gradientLayer.colors = [
                UIColor.systemBlue.cgColor,
                UIColor.systemOrange.cgColor
            ]
        } else if temperature >= 20 && temperature < 40 {
            gradientLayer.colors = [
                UIColor.systemYellow.cgColor,
                UIColor.systemOrange.cgColor
            ]
        }
    }
    /// Life Cycle.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
        setupIndicator()
    }
    ///Laout Subviews.
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        updateIndicator()
    }
}
