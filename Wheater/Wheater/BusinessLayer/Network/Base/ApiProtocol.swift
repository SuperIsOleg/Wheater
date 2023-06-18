//
//  ApiProtocol.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import Alamofire

protocol ApiProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var body: [String : Any]? { get }
}

extension ApiProtocol {
    var baseURL: String {
        return NetworkConstants.baseUrl
    }
}
