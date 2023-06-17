//
//  WheaterViewController.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit

final class WheaterViewController: UIViewController {
    private lazy var wheaterView = WheaterView()
    private let viewModel: WheaterViewModel

    override func loadView() {
        super.loadView()
        self.view = wheaterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wheaterView.tableView.delegate = self
        self.wheaterView.tableView.dataSource = self
        
        self.wheaterView.tableView.sectionHeaderHeight = 300.0
    }

    init(viewModel: WheaterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UITableViewDelegate
extension WheaterViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderTableView()
        return header
    }
    

}

// MARK: - UITableViewDataSource
extension WheaterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTodayTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? WeatherTodayTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
    
}
