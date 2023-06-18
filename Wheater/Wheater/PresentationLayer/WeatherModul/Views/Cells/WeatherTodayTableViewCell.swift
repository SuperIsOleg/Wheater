//
//  TableViewCell.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit

final class WeatherTodayTableViewCell: UITableViewCell {
    static var reuseIdentifier = String(describing: WeatherTodayTableViewCell.self)
    
    private let containerView: UIVisualEffectView = {
        let visualView = UIVisualEffectView()
        let bluerEffect = UIBlurEffect(style: .light)
        visualView.effect = bluerEffect
        visualView.layer.cornerRadius = 12
        visualView.clipsToBounds = true
        return visualView
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "jhcjz jdhcjkdshj djkhcjd cjd kdcksjks cjd dcsbcbschdb cskdjkcjsk"
        label.lineBreakMode = .byWordWrapping
        label.font = R.font.helveticaNeueThin(size: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let _weatherTodayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CurrentWeatherCollectionViewCell.self,
                                forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    internal var weatherTodayCollectionView: UICollectionView {
        get {
            return _weatherTodayCollectionView
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
        self.selectionStyle = .none
        
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        })
        
        self.containerView.contentView.addSubview(informationLabel)
        informationLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        })

        self.containerView.contentView.addSubview(_weatherTodayCollectionView)
        _weatherTodayCollectionView.snp.makeConstraints({
            $0.top.equalTo(informationLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        })
    }
}
