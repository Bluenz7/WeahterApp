//
//  SecondCollectionCell.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 20.05.2025.
//

import Foundation
import UIKit
import Kingfisher

class SecondCollectionViewCell: UICollectionViewCell{
    
    // MARK: - Model.
    
    struct Model {
        var date: String?
        var icon: URL?
        var mintemp_c: Double?
        var maxtemp_c: Double?
    }
    
    // MARK: - Private Properties.
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .white
//        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageURL: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .white
//        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .white
//        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private let separatorView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
//        view.layer.cornerRadius = 2
//        return view
//    }()
    
  
    // MARK: - TemperatureGradintBar.
    
    private let temperatureBar = TemperatureGradientBar()
    
    // MARK: - Setup Cell.
    
    private func setupCell() {
        addSubview(timeLabel)
        addSubview(imageURL)
        addSubview(minTempLabel)
        addSubview(temperatureBar)
        addSubview(maxTempLabel)
//        addSubview(separatorView)
        backgroundColor = UIColor(red: 35/255, green: 51/255, blue: 98/255, alpha: 15)
        setConstraints()
    }
    
    // MARK: - Life Cycle.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Update Temperature.
    func updateTemperature(_ temperature: Double) {
        temperatureBar.temperature = temperature
    }
//    /// Set Separator Hidden.
//    internal func setSeparatorHidden(_ hidden: Bool) {
//        separatorView.isHidden = hidden
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        setSeparatorHidden(false)
        updateTemperature(20)
    }
}

// MARK: - Setup Configuration.

extension SecondCollectionViewCell {
    func configuredCell(by model: Any) {
        guard let model = model as? Model else { return }
        timeLabel.text = model.date
        imageURL.kf.setImage(with: model.icon)
        minTempLabel.text = "\(Double(model.mintemp_c ?? 0))º"
        maxTempLabel.text = "\(Double(model.maxtemp_c ?? 0))º"
    }
}

// MARK: - Setup Constraints.

extension SecondCollectionViewCell {
    func setConstraints() {
        temperatureBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
//            timeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            
    
            imageURL.leftAnchor.constraint(equalTo: leftAnchor, constant: 130),
//            imageURL.rightAnchor.constraint(equalTo: rightAnchor, constant: -180),
            imageURL.widthAnchor.constraint(equalToConstant: 40),
            imageURL.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageURL.heightAnchor.constraint(equalToConstant: 40),
            
//            minTempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            minTempLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 180),
            minTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            minTempLabel.rightAnchor.constraint(equalTo: rightAnchor),
//            minTempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            
//            temperatureBar.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            temperatureBar.leftAnchor.constraint(equalTo: minTempLabel.rightAnchor, constant: 10),
//            temperatureBar.rightAnchor.constraint(equalTo: rightAnchor),
//            temperatureBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            temperatureBar.heightAnchor.constraint(equalToConstant: 10),
            temperatureBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureBar.widthAnchor.constraint(equalToConstant: 60),
            
//            maxTempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            maxTempLabel.leftAnchor.constraint(equalTo: temperatureBar.rightAnchor, constant: 10),
            maxTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            maxTempLabel.rightAnchor.constraint(equalTo: rightAnchor),
//            maxTempLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
//            separatorView.widthAnchor.constraint(equalToConstant: 300),
//            separatorView.heightAnchor.constraint(equalToConstant: 1),
//            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            
        ])
    }
}

//protocol SeparatorDisplayable: AnyObject {
//    func setSeparatorHidden(_ hidden: Bool)
//}
