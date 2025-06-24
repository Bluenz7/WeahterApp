//
//  AnimatedWeather.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 27.05.2025.
//

import Foundation

import UIKit

class AnimatedWeatherBackgroundView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        animateGradient()
        addStars()
        addClouds()
        addRain()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
        animateGradient()
        addStars()
        addClouds()
        addRain()
    }
    // MARK: - Life Cycle.
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    // MARK: - Gradient Background
    private func setupGradient() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor(red: 15/255, green: 17/255, blue: 40/255, alpha: 1.0).cgColor,
            UIColor(red: 40/255, green: 60/255, blue: 110/255, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.addSublayer(gradientLayer)
    }
    
    private func animateGradient() {
        let toColors: [CGColor] = [
            UIColor(red: 20/255, green: 24/255, blue: 80/255, alpha: 1.0).cgColor,
            UIColor(red: 70/255, green: 100/255, blue: 180/255, alpha: 1.0).cgColor
        ]
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = toColors
        animation.duration = 8.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        
        gradientLayer.add(animation, forKey: "colorChange")
    }
    
    // MARK: - Stars
    private func addStars() {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: bounds.width / 2.2, y: 150)
        emitter.emitterSize = CGSize(width: bounds.width, height: 1)
        emitter.emitterShape = .sphere
        
        let star = CAEmitterCell()
        star.birthRate = 3
        star.lifetime = 60
        star.velocity = 0.025
        star.scale = 0.15
        star.scaleRange = 0.12
        star.alphaSpeed = -0.1
        star.contents = starImage(color: .white).cgImage
        
        emitter.emitterCells = [star]
        layer.addSublayer(emitter)
    }
    
    // MARK: - Clouds
    private func addClouds() {
        for i in 0..<25 {
            let cloudImage = UIImage(named: "realisticCloud")
            let cloudView = UIImageView(image: cloudImage)
            
            // Настройки внешнего вида.
            cloudView.alpha = CGFloat.random(in: 0.15...0.35)
            cloudView.contentMode = .scaleAspectFit
            cloudView.layer.opacity = 0.8
            cloudView.layer.masksToBounds = false
            
            // Розмер и позиция.
            let width: CGFloat = CGFloat.random(in: 180...350)
            let height = width * CGFloat.random(in: 0.4...0.6)
            let yPosition: CGFloat = CGFloat.random(in: 30...(bounds.height / 2.5))
            
            cloudView.frame = CGRect(x: -width, y: yPosition, width: width, height: height)
            addSubview(cloudView)
            
            // Медленная анимация перемешения (плытья) облаков.
            UIView.animate(
                withDuration: Double.random(in: 100...160),
                delay: Double(i) * 6.0,
                options: [.repeat, .curveLinear],
                animations: {
                    cloudView.frame.origin.x = self.bounds.width + width
                },
                completion: nil
            )
        }
    }
    
    // MARK: - Rain
    private func addRain() {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: bounds.width / 2, y: -10)
        emitter.emitterSize = CGSize(width: bounds.width, height: 1)
        emitter.emitterShape = .line
        
        let rainDrop = CAEmitterCell()
        rainDrop.birthRate = 70
        rainDrop.lifetime = 5.0
        rainDrop.velocity = 300
        rainDrop.velocityRange = 100
        rainDrop.emissionLongitude = .pi
        rainDrop.scale = 0.2
        rainDrop.contents = makeRaindropImage(color: .white.withAlphaComponent(0.7)).cgImage
        rainDrop.alphaSpeed = -0.2
        
        emitter.emitterCells = [rainDrop]
        layer.addSublayer(emitter)
    }
}

// MARK: - Setup Rain demonstration.
private func makeRaindropImage(color: UIColor) -> UIImage {
    let size = CGSize(width: 2, height: 10)
    let renderer = UIGraphicsImageRenderer(size: size)
    
    return renderer.image { context in
        let rect = CGRect(origin: .zero, size: size)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 4)
        color.setFill()
        path.fill()
    }
}

// MARK: - Setup Stars demonstration.
private func starImage(color: UIColor) -> UIImage {
    let size = CGSize(width: 6, height: 6)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fillEllipse(in: CGRect(origin: .zero, size: size))
    
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}
