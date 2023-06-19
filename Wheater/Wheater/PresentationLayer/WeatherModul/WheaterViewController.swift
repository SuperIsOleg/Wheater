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
        self.wheaterView.setLoadingState(isLoading: true)
        self.viewModel.getWeather(completion: { result in
            switch result {
            case .success(_):
                self.wheaterView.setLoadingState(isLoading: false)
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
        switch tableView {
        case is WeatherTableView:
            let header = HeaderTableView()
            guard let weatherModel = self.viewModel.weatherModel else { return header }
            header.configure(model: weatherModel)
            return header
        case is DalyWeatherTableView:
            return nil
        default:
            return nil
        }
    }
    
    
}

// MARK: - UITableViewDataSource
extension WheaterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case is WeatherTableView:
            return 2
        case is DalyWeatherTableView:
            guard let weatherModel = self.viewModel.weatherModel else { return 0 }
            return weatherModel.daily.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherModel = self.viewModel.weatherModel else { return UITableViewCell() }
        
        switch tableView {
        case is WeatherTableView:
            switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTodayTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? WeatherTodayTableViewCell else { return UITableViewCell() }
                cell.weatherTodayCollectionView.delegate = self
                cell.weatherTodayCollectionView.dataSource = self
                cell.configure(model: weatherModel)
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForTheWeekTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? WeatherForTheWeekTableViewCell else { return UITableViewCell() }
                cell.configure(model: weatherModel.daily)
                cell.weatherForTheWeekTableView.delegate = self
                cell.weatherForTheWeekTableView.dataSource = self
                return cell
            default:
                return UITableViewCell()
            }
        case is DalyWeatherTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForTheDayTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? WeatherForTheDayTableViewCell,
                  let dayModel = weatherModel.daily[safe: indexPath.row],
                  let weatherDay = dayModel.weather.first else { return UITableViewCell() }
            cell.configure(model: dayModel)
            cell.setLoadingState(isLoading: true)
            if let data = dayModel.imageData {
                cell.setImage(data: data)
            } else {
                self.viewModel.getIcon(codeIcon: weatherDay.icon, completion: { result in
                    switch result {
                    case .success(let data):
                        cell.setImage(data: data)
                    case .failure(let error):
                        self.showAlert(error.localizedDescription)
                    }
                    cell.setLoadingState(isLoading: false)
                })
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case is WeatherTableView:
            switch indexPath.row {
            case 0:
                return 200
            case 1:
                return 450
            default:
                return UITableView.automaticDimension
            }
        case is DalyWeatherTableView:
            return 44
        default:
            return UITableView.automaticDimension
        }
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
        
        if let data = horlyModel.imageData {
            cell.setImage(data: data)
        } else {
            cell.setLoadingState(isLoading: true)
            self.viewModel.getIcon(codeIcon: weather.icon, completion: { result in
                switch result {
                case .success(let data):
                    cell.setImage(data: data)
                    self.viewModel.weatherModel?.hourly[indexPath.row].imageData = data
                case .failure(let error):
                    self.showAlert(error.localizedDescription)
                }
                cell.setLoadingState(isLoading: false)
            })
        }
        
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
