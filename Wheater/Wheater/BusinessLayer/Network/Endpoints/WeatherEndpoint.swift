//
//  WeatherEndpoint.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import Alamofire

enum WeatherEndpoint {
    case getCurrentWeather
}

extension WeatherEndpoint: ApiProtocol {
    var path: String {
        switch self {
        case .getCurrentWeather:
            return ""
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getCurrentWeather:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders {
        switch self {
        case .getCurrentWeather:
            return [:]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getCurrentWeather:
            return nil
        }
    }
    
    
}
