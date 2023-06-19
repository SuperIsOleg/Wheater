//
//  LoadableImageView.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 19.06.23.
//

import UIKit

class LoadableImageView: UIImageView {
    internal var loaderView: LoadingView = {
        let loaderView = LoadingView()
        loaderView.backgroundColor = .clear
        return loaderView
    }()

    override init(image: UIImage?) {
        super.init(image: image)
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(loaderView)
        loaderView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
        
        loaderView.isHidden = true
    }
    
    internal func setLoadingState(isLoading: Bool) {
        self.loaderView.isHidden = !isLoading
    }
}
