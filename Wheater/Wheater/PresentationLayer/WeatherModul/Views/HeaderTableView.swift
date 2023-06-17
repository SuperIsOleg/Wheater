//
//  HeaderTableView.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit

final class HeaderTableView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .brown
    }
    
}
