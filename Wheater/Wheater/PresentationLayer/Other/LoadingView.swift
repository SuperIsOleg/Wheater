//
//  LoadingView.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 19.06.23.
//

import UIKit

class LoadingView: UIView {
    private var loader = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .white.withAlphaComponent(1)
        loader.startAnimating()
        self.addSubview(loader)
        loader.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        })
    }

}
