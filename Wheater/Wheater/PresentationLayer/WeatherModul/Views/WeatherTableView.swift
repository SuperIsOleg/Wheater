//
//  WeatherTableView.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit

class WeatherTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(WeatherTodayTableViewCell.self, forCellReuseIdentifier: WeatherTodayTableViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
