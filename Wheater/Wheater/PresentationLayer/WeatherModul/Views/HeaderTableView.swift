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
        stackView.distribution = .equalCentering
        stackView.spacing = 15
        return stackView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Minsk"
        label.textAlignment = .center
        return label
    }()
    
    private let temperatureLabel: UILabel = {
       let label = UILabel()
        label.text = "21"
        label.textAlignment = .center
        return label
    }()
    
    private let currentState: UILabel = {
       let label = UILabel()
        label.text = "Mostly Cloude"
        label.textAlignment = .center
        return label
    }()
    
    private let currentWeather: UILabel = {
       let label = UILabel()
        label.text = R.string.localizable.weatherCurrentWeather(29, 15)
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
        cityLabel.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        })
        
        stackView.addArrangedSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints({
            $0.top.equalTo(cityLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        })
        
        stackView.addArrangedSubview(currentState)
        currentState.snp.makeConstraints({
            $0.top.equalTo(temperatureLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        })
        
        stackView.addArrangedSubview(currentWeather)
        currentWeather.snp.makeConstraints({
            $0.top.equalTo(currentState.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
    
}
