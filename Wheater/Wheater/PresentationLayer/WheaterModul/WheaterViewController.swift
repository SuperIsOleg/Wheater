//
//  WheaterViewController.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit

class WheaterViewController: UIViewController {
    private lazy var wheaterView = WheaterView()
    private let viewModel: WheaterViewModel

    override func loadView() {
        super.loadView()
        self.view = wheaterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(viewModel: WheaterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

