//
//  HeaderTableView.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit

final class HeaderTableView: UIView {
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .none
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Minsk"
        label.font = R.font.helveticaNeueThin(size: 40)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let temperatureLabel: UILabel = {
       let label = UILabel()
        label.text = "21°"
        label.font = R.font.helveticaNeueThin(size: 100)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let currentState: UILabel = {
       let label = UILabel()
        label.text = "Mostly Cloude"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let currentWeather: UILabel = {
       let label = UILabel()
        label.text = R.string.localizable.weatherCurrentWeather(29, 15)
        label.font = R.font.helveticaNeueThin(size: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .clear
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints({
            $0.centerX.centerY.equalToSuperview()
        })
        
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(currentState)
        stackView.addArrangedSubview(currentWeather)
    }
    
}
