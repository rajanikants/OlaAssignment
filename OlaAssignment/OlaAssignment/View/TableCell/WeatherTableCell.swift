//
//  WeatherTableCell.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

class WeatherTableCell: UITableViewCell {
    
    private let nameAndTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var tempContainerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minTempLabel,
                                                            maxTempLabel])
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameAndTempLabel,
                                                            tempContainerStack])
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        setupViews()
        setupConstraints()
    }
}

private extension WeatherTableCell {
    
    func setupViews() {
        contentView.addSubview(containerStack)
    }
    
    func setupConstraints() {
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

extension WeatherTableCell {
    
    func configureCell(detail: WeatherInfo) {
        
        let cityName = detail.cityName ?? ""
        let temperature = detail.temperature ?? ""
        let minTemp = detail.minTemp ?? ""
        let maxTemp = detail.maxTemp ?? ""
        
        nameAndTempLabel.text = "\(cityName) - \(temperature)"
        minTempLabel.text = "Min Temp: \(minTemp)"
        maxTempLabel.text = "Max Temp: \(maxTemp)"
    }
}
