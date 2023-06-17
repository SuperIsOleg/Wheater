//
//  TableViewCell.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit

final class WeatherTodayTableViewCell: UITableViewCell {
    static var reuseIdentifier = String(describing: WeatherTodayTableViewCell.self)
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.alpha = 0.5
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "dsbvjknbdfhjbvdklsnvjkcndsacklfnjknkldsnj shdcjfsuihidhcjuindsklsncjks"
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private let weatherTodayCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = .clear
        
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        })
        
        self.containerView.addSubview(informationLabel)
        informationLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        })
        
        self.containerView.addSubview(weatherTodayCollectionView)
        weatherTodayCollectionView.snp.makeConstraints({
            $0.top.equalTo(informationLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
            $0.height.equalTo(80)
        })
    }
}
