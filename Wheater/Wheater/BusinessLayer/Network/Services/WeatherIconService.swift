//
//  WeatherIconService.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 19.06.23.
//

import Foundation

protocol WeatherIconServiceProtocol {
    func getIcon(codeIcon: String, completion: @escaping (Result<Data, RequestError>) -> Void)
}

struct WeatherIconService: HTTPClient, WeatherIconServiceProtocol {
    func getIcon(codeIcon: String, completion: @escaping (Result<Data, RequestError>) -> Void) {
        download(requestApi: WeatherIconEnpoint.getIcon(code: codeIcon), completion: completion)
    }
}
