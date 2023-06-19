//
//  WheaterView.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit
import SnapKit

final class WheaterView: UIView {
    
    private var loadingView: LoadingView = {
        let view = LoadingView()
        view.layer.zPosition = 10
        view.isHidden = true
        return view
    }()
    
    private let _tableView: WeatherTableView = {
        let tableView = WeatherTableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    internal var tableView: WeatherTableView {
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
        
        self.addSubview(loadingView)
        loadingView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        self.addSubview(_tableView)
        _tableView.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        })
    }
    
    internal func setLoadingState(isLoading: Bool) {
        UIView.animate(withDuration: 0.3,
                       animations: {
            isLoading ? (self.loadingView.alpha = 1) : (self.loadingView.alpha = 0)
        }, completion: {_ in
            self.loadingView.isHidden = !isLoading
        })
    }
}
