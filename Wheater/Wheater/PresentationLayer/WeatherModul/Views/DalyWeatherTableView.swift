//
//  DalyWeatherTableView.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 19.06.23.
//

import UIKit

final class DalyWeatherTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(WeatherForTheDayTableViewCell.self, forCellReuseIdentifier: WeatherForTheDayTableViewCell.reuseIdentifier)
        self.isScrollEnabled = false
        self.layer.zPosition = 5
        self.backgroundColor = .clear
        self.separatorStyle = .none
        self.sectionHeaderHeight = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
