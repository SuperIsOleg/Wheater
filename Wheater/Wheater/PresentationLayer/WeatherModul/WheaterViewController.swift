//
//  WheaterViewController.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit
import AVFoundation

final class WheaterViewController: UIViewController {
    private lazy var wheaterView = WheaterView()
    private let viewModel = WheaterViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = wheaterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.wheaterView.tableView.delegate = self
        self.wheaterView.tableView.dataSource = self
        self.wheaterView.tableView.rowHeight = 200
        self.wheaterView.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.wheaterView.tableView.sectionHeaderHeight = 350.0
        
        self.viewModel.getWeather(completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self.showAlert(error.localizedDescription)
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupBackgroundVideo()
    }
    
    private func setupBackgroundVideo() {
        guard let path = Bundle.main.path(forResource: "BackgroundVideo", ofType: "mp4") else { return }
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.zPosition = 0
        player.isMuted = true
        playerLayer.frame = self.wheaterView.bounds
        self.wheaterView.layer.addSublayer(playerLayer)
        player.play()
    }
    
}

// MARK: - UITableViewDelegate
extension WheaterViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderTableView()
        guard let weatherModel = self.viewModel.weatherModel else { return header }
        header.configure(model: weatherModel)
        return header
    }
    
    
}

// MARK: - UITableViewDataSource
extension WheaterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTodayTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? WeatherTodayTableViewCell,
                  let weatherModel = self.viewModel.weatherModel else { return UITableViewCell() }
            cell.weatherTodayCollectionView.delegate = self
            cell.weatherTodayCollectionView.dataSource = self
            cell.configure(model: weatherModel)
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
}

// MARK: - UICollectionViewDelegate
extension WheaterViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - UICollectionViewDataSource
extension WheaterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? CurrentWeatherCollectionViewCell,
              let weatherModel = self.viewModel.weatherModel,
              let horlyModel = weatherModel.hourly[safe: indexPath.row],
              let weather = horlyModel.weather.first else { return UICollectionViewCell() }
        cell.configure(model: horlyModel)
        self.viewModel.getIcon(codeIcon: weather.icon, completion: { result in
            switch result {
            case .success(let data):
                cell.setImage(data: data)
            case .failure(let error):
                self.showAlert(error.localizedDescription)
            }
        })

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WheaterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeForItemAt = CGSize(width: 50,
                                   height: 80)
        return sizeForItemAt
    }
    
}

// MARK: - WheaterViewModelDelegate
extension WheaterViewController: WheaterViewModelDelegate {
    func reloadData() {
        self.wheaterView.tableView.reloadData()
    }
    
}
