//
//  FirstCollectionViewCell.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 20.05.2025.
//

import Kingfisher
import Foundation
import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Model.
    struct Model {
        var hour: String?
        var iconURL: URL?
        var temp: Double?
    }
    
    //MARK: - Private Properties.
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("", comment: "Просто как пример поставлена данная система")
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageURL: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Setup Cell.
    private func setupCell() {
        addSubview(hourLabel)
        addSubview(imageURL)
        addSubview(tempLabel)
        setConstraints()
        backgroundColor = UIColor(red: 35/255, green: 51/255, blue: 98/255, alpha: 15)
    }
    
    //MARK: - Life Cycle.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup Configuration.
extension FirstCollectionViewCell {
    func configuredCell(by model: Any) {
        guard let model = model as? Model else { return }
        hourLabel.text = model.hour
        imageURL.kf.setImage(with: model.iconURL)
        tempLabel.text = "\((model.temp ?? 0))º"
    }
}
//MARK: - Setup Constraints.
extension FirstCollectionViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            hourLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageURL.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 5),
            imageURL.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageURL.widthAnchor.constraint(equalToConstant: 35),
            imageURL.heightAnchor.constraint(equalToConstant: 35),
            
            tempLabel.topAnchor.constraint(equalTo: imageURL.bottomAnchor, constant: 5),
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

