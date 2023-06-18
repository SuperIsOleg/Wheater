//
//  WeatherService.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import Foundation

protocol WeatherServiceProtocol {
    func getCurrentWeather(completion: @escaping (Result<WeatherModel, RequestError>) -> Void)
}

struct WeatherService: HTTPClient, WeatherServiceProtocol {
    func getCurrentWeather(completion: @escaping (Result<WeatherModel, RequestError>) -> Void) {
        request(decoder: SnakeCaseDecoder(), requestApi: WeatherEndpoint.getCurrentWeather, model: WeatherModel.self, completion: completion)
    }

}
