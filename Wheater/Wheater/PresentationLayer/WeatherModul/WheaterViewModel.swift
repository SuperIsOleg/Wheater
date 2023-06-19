//
//  WheaterViewModel.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import Foundation
import OSLog

protocol WheaterViewModelProtocol {
    func getWeather(completion: @escaping (Result<WeatherModel, RequestError>) -> Void)
    func getIcon(codeIcon: String, completion: @escaping (Result<Data, RequestError>) -> Void)
}

protocol WheaterViewModelDelegate: AnyObject {
    func reloadData()
}

final class WheaterViewModel: WheaterViewModelProtocol {
    private let weatherService = WeatherService()
    private let weatherIconService = WeatherIconService()
    internal var weatherModel: WeatherModel? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.reloadData()
            }
        }
    }
    internal weak var delegate: WheaterViewModelDelegate?
    
    internal  func getWeather(completion: @escaping (Result<WeatherModel, RequestError>) -> Void) {
        self.weatherService.getCurrentWeather(completion: { result in
            switch result {
            case .success(let weatherResult):
                self.weatherModel = weatherResult
            case .failure(let error):
                os_log("Error in \(#function) - \(error.localizedDescription)")
            }
            completion(result)
        })
    }
    
    internal func getIcon(codeIcon: String, completion: @escaping (Result<Data, RequestError>) -> Void) {
        self.weatherIconService.getIcon(codeIcon: codeIcon, completion: { result in
            completion(result)
        })
    }
    
    
}
