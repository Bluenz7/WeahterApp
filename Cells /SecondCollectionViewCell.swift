//
//  SecondCollectionCell.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 20.05.2025.
//

import Foundation
import UIKit
import Kingfisher

class SecondCollectionViewCell: UICollectionViewCell, SeparatorDisplayable {
    
    //MARK: - Model.
    struct Model {
        var date: String?
        var icon: URL?
        var mintemp_c: Double?
        var maxtemp_c: Double?
    }
    
    //MARK: - Private Properties.
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
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
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        view.layer.cornerRadius = 2
        return view
    }()
    
    //MARK: - TemperatureGradintBar.
    private let temperatureBar = TemperatureGradientBar()
    
    //MARK: - Setup Cell.
    private func setupCell() {
        addSubview(timeLabel)
        addSubview(imageURL)
        addSubview(minTempLabel)
        addSubview(temperatureBar)
        addSubview(maxTempLabel)
        addSubview(separatorView)
        backgroundColor = UIColor(red: 35/255, green: 51/255, blue: 98/255, alpha: 15)
        setConstraints()
    }
    
    //MARK: - Life Cycle.
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
    /// Set Separator Hidden.
    internal func setSeparatorHidden(_ hidden: Bool) {
        separatorView.isHidden = hidden
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setSeparatorHidden(false)
        updateTemperature(20)
    }
}

//MARK: - Setup Configuration.
extension SecondCollectionViewCell {
    func configuredCell(by model: Any) {
        guard let model = model as? Model else { return }
        timeLabel.text = model.date
        imageURL.kf.setImage(with: model.icon)
        minTempLabel.text = "\(Double(model.mintemp_c ?? 0))º"
        maxTempLabel.text = "\(Double(model.maxtemp_c ?? 0))º"
    }
}

//MARK: - Setup Constraints.
extension SecondCollectionViewCell {
    func setConstraints() {
        temperatureBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            imageURL.topAnchor.constraint(equalTo: topAnchor, constant: -2),
            imageURL.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 20),
            imageURL.widthAnchor.constraint(equalToConstant: 45),
            imageURL.heightAnchor.constraint(equalToConstant: 45),
            
            minTempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            minTempLabel.leadingAnchor.constraint(equalTo: imageURL.trailingAnchor, constant: 15),
            
            temperatureBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            temperatureBar.leadingAnchor.constraint(equalTo: minTempLabel.trailingAnchor, constant: 5),
            temperatureBar.heightAnchor.constraint(equalToConstant: 8),
            temperatureBar.widthAnchor.constraint(equalToConstant: 55),
            
            maxTempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            maxTempLabel.leadingAnchor.constraint(equalTo: temperatureBar.trailingAnchor, constant: 5),
            
            separatorView.widthAnchor.constraint(equalToConstant: 300),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            
        ])
    }
}

protocol SeparatorDisplayable: AnyObject {
    func setSeparatorHidden(_ hidden: Bool)
}

