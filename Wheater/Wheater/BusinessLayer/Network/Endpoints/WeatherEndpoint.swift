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
            return "/data/3.0/onecall"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getCurrentWeather:
            return .get
        }
    }
    
    var parameters: Alamofire.Parameters {
        switch self {
        case .getCurrentWeather:
            return [
               "lat" : "53.893009",
               "lon" : "27.567444",
               "exclude" : "minutely",
               "units" : "metric",
               "appid" : NetworkConstants.apiKey
            ]
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
