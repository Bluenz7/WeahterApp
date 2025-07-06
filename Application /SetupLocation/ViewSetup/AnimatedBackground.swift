////
////  View.swift
////  WeatherApplication
////
////  Created by Владислав Скриганюк on 26.05.2025.
////
//
//import Foundation
//import UIKit
//
//class AnimatedBackgroundView: UIView {
//    
//    private let gradientLayer = CAGradientLayer()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupGradient()
//        animateGradient()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupGradient()
//        animateGradient()
//    }
//
//    private func setupGradient() {
//        gradientLayer.frame = bounds
//        gradientLayer.colors = [
//            UIColor(red: 15/255, green: 17/255, blue: 40/255, alpha: 1.0).cgColor, // початковий
//            UIColor(red: 64/255, green: 156/255, blue: 255/255, alpha: 1.0).cgColor // світліший
//        ]
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
//        layer.addSublayer(gradientLayer)
//    }
//
//    private func animateGradient() {
//        let fromColors = gradientLayer.colors
//        let toColors: [CGColor] = [
//            UIColor(red: 40/255, green: 60/255, blue: 110/255, alpha: 1.0).cgColor,
//            UIColor(red: 90/255, green: 180/255, blue: 255/255, alpha: 1.0).cgColor
//        ]
//
//        let animation = CABasicAnimation(keyPath: "colors")
//        animation.fromValue = fromColors
//        animation.toValue = toColors
//        animation.duration = 6.0
//        animation.autoreverses = true
//        animation.repeatCount = .infinity
//
//        gradientLayer.add(animation, forKey: "colorChange")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        gradientLayer.frame = bounds
//    }
//}
