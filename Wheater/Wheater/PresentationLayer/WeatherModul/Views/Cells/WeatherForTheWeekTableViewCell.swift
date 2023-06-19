//
//  WeatherForTheWeekTableViewCell.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 19.06.23.
//

import UIKit

final class WeatherForTheWeekTableViewCell: UITableViewCell {
    static var reuseIdentifier = String(describing: WeatherForTheWeekTableViewCell.self)
    
    private let containerView: UIVisualEffectView = {
        let visualView = UIVisualEffectView()
        let bluerEffect = UIBlurEffect(style: .light)
        visualView.effect = bluerEffect
        visualView.layer.cornerRadius = 12
        visualView.clipsToBounds = true
        return visualView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.helveticaNeueThin(size: 15)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let _weatherForTheWeekTableView: DalyWeatherTableView = {
        let tableView = DalyWeatherTableView()
        return tableView
    }()
    
    internal var weatherForTheWeekTableView: DalyWeatherTableView {
        get {
            return _weatherForTheWeekTableView
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        })
        
        self.containerView.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        })

        self.containerView.contentView.addSubview(_weatherForTheWeekTableView)
        _weatherForTheWeekTableView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        })
    }
    
    internal func configure(model: [Daily]) {
        self.titleLabel.text = R.string.localizable.weatherDayForecast(model.count).uppercased()
    }

}
