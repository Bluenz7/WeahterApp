//
//  SecondCollectionCell.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 20.05.2025.
//

import Foundation
import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
//MARK: - Private Properties.
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(secondLabel)
        addSubview(thirdLabel)
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
extension SecondCollectionViewCell {
    func configuredCell(firstText: String?, secondText: Int?, thirdText: Int?) {
        firstLabel.text = firstText
        secondLabel.text = "\(secondText ?? 0)"
        thirdLabel.text = "\(thirdText ?? 0)"
    }
}

//MARK: - Setup Constraints.
extension SecondCollectionViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            firstLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            secondLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            secondLabel.leadingAnchor.constraint(equalTo: firstLabel.leadingAnchor, constant: 150),
            
            thirdLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            thirdLabel.leadingAnchor.constraint(equalTo: secondLabel.leadingAnchor, constant: 50)
            
        ])
    }
}
