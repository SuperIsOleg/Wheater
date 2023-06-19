//
//  WeatherIconEnpoint.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 19.06.23.
//

import Alamofire

enum WeatherIconEnpoint {
    case getIcon(code: String)
}

extension WeatherIconEnpoint: ApiProtocol {
    var path: String {
        switch self {
        case .getIcon(let code):
            return "/img/wn/\(code).png"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getIcon:
            return .get
        }
    }
    
    var parameters: Alamofire.Parameters {
        switch self {
        case .getIcon:
            return [:]
        }
    }
    
    var headers: Alamofire.HTTPHeaders {
        switch self {
        case .getIcon:
            return [
               "Content-Type" : "multipart/form-data"
            ]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getIcon:
            return nil
        }
    }
    

}
