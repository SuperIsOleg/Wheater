//
//  WheaterView.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit
import SnapKit

final class WheaterView: UIView {
    
    private let _tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(WeatherTodayTableViewCell.self, forCellReuseIdentifier: WeatherTodayTableViewCell.reuseIdentifier)
        tableView.sectionHeaderTopPadding = 0
        tableView.layer.zPosition = 3
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    internal var tableView: UITableView {
        get {
            return _tableView
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        self.addSubview(_tableView)
        _tableView.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        })
    }
}
