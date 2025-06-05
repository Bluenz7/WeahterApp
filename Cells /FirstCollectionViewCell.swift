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
    
    
    struct model {
        
    }
//MARK: - Private Properties.
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = ""
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
    
    private let thirdLabel: UILabel = {
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
        addSubview(firstLabel)
        addSubview(imageURL)
        addSubview(thirdLabel)
        setConstraints()
        backgroundColor = UIColor(red: 35/255, green: 51/255, blue: 98/255, alpha: 15)
    }
    
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
    func configuredCell(firstText: String?, url: URL?, thirdText: Double?) {
        firstLabel.text = firstText
        imageURL.kf.setImage(with: url)
        thirdLabel.text = "\(thirdText ?? 0)"
    }
}
//MARK: - Setup Constraints.
extension FirstCollectionViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            firstLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
            imageURL.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 5),
            imageURL.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageURL.widthAnchor.constraint(equalToConstant: 35),
            imageURL.heightAnchor.constraint(equalToConstant: 35),
            
            thirdLabel.topAnchor.constraint(equalTo: imageURL.bottomAnchor, constant: 5),
            thirdLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

