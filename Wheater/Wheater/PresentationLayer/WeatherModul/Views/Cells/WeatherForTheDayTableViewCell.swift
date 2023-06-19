//
//  WeatherForTheDayTableViewCell.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 19.06.23.
//

import UIKit

final class WeatherForTheDayTableViewCell: UITableViewCell {
    static var reuseIdentifier = String(describing: WeatherForTheDayTableViewCell.self)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .none
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.helveticaNeueThin(size: 20)
        label.text = "Today"
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.сloud()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let lowLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.helveticaNeueThin(size: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let temperatureProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.8
        
        progressView.backgroundColor = .clear
        progressView.progressTintColor = .yellow
        progressView.trackTintColor = .systemBlue
        return progressView
    }()
    
    private let highLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.helveticaNeueThin(size: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
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
        
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        })
        
        
        self.stackView.addArrangedSubview(dayLabel)
        self.stackView.addArrangedSubview(weatherImageView)
        weatherImageView.snp.makeConstraints({
            $0.width.height.equalTo(30)
        })
        self.stackView.addArrangedSubview(containerView)
        
        containerView.snp.makeConstraints({
            $0.width.equalTo(self.bounds.width / 2)
        })
        
        self.containerView.addSubview(lowLabel)
        lowLabel.snp.makeConstraints({
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        })
        
        self.containerView.addSubview(highLabel)
        highLabel.snp.makeConstraints({
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        })
        
        self.containerView.addSubview(temperatureProgressView)
        temperatureProgressView.snp.makeConstraints({
            $0.leading.equalTo(lowLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(highLabel.snp.leading).offset(-10)
            $0.centerY.equalToSuperview()
        })
        
    }
    
    internal func configure(model: Daily) {
        let curentHoure = Date.getCurrentDate(format: "dd-MM-yyyy")
        let weatherOfTheDay = model.weatherByDate.convertDate(from: "dd-MM-yyyy'T'HH:mm:ss", to: "dd-MM-yyyy")
        self.dayLabel.text = curentHoure == weatherOfTheDay ? R.string.localizable.weatherToday() : model.weatherByDate.convertDate(from: "dd-MM-yyyy'T'HH:mm:ss", to: "EEEE")
        self.lowLabel.text = String(format: "%g", model.temp.min.rounded(.down)) + "°"
        self.highLabel.text = String(format: "%g", model.temp.max.rounded(.down)) + "°"
    }
    
    internal func setImage(data: Data) {
        self.weatherImageView.image = UIImage(data: data)
    }
}

