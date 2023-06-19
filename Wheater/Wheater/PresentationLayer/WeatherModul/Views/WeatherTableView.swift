//
//  WeatherTableView.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 19.06.23.
//

import UIKit

final class WeatherTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
       self.register(WeatherTodayTableViewCell.self, forCellReuseIdentifier: WeatherTodayTableViewCell.reuseIdentifier)
       self.register(WeatherForTheWeekTableViewCell.self, forCellReuseIdentifier: WeatherForTheWeekTableViewCell.reuseIdentifier)
       self.sectionHeaderTopPadding = 0
       self.layer.zPosition = 3
       self.backgroundColor = .clear
       self.separatorStyle = .none
       self.sectionHeaderHeight = 350.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
