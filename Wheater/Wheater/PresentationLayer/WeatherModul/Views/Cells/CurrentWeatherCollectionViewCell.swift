//
//  CurrentWeatherCollectionViewCell.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import UIKit

final class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = String(describing: CurrentWeatherCollectionViewCell.self)
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.helveticaNeueThin(size: 15)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let weatherImageView: LoadableImageView = {
        let imageView = LoadableImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let degreesLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.helveticaNeueThin(size: 15)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        self.containerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        })
        
        self.containerView.addSubview(weatherImageView)
        weatherImageView.snp.makeConstraints({
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(30)
        })
        
        self.containerView.addSubview(degreesLabel)
        degreesLabel.snp.makeConstraints({
            $0.top.equalTo(weatherImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        })
    }
    
    internal func configure(model: Hourly) {
        let curentHoure = Date.getCurrentDate(format: "HH")
        let timeWeather = model.hourlyWeather.convertDate(from: "dd-MM-yyyy'T'HH:mm:ss", to: "HH")
        self.timeLabel.text = timeWeather == curentHoure ? R.string.localizable.weatherNow() : timeWeather
        self.degreesLabel.text = String(format: "%g", model.temp.rounded(.down)) + "°"
    }
    
    internal func setImage(data: Data) {
        self.weatherImageView.image = UIImage(data: data)
    }
    
    internal func setLoadingState(isLoading: Bool) {
        self.weatherImageView.setLoadingState(isLoading: isLoading)
    }
}
