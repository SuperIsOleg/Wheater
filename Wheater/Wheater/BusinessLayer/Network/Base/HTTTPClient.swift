//
//  HTTTPClient.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import Foundation
import Alamofire


protocol HTTPClient {
    func request<T: ApiProtocol, U: Decodable>(decoder: JSONDecoder, requestApi: T, model: U.Type, completion: @escaping (Result<U, RequestError>) -> Void)
    func download<T: ApiProtocol>(requestApi: T, completion: @escaping (Result<Data, RequestError>) -> Void)
}

extension HTTPClient {
    /**
     Complete Http request with parameters.
     - parameter T: api configuration of request including url, parameters, method, etc
     - parameter U: model to decode result of reponse
     */
    func request<T: ApiProtocol, U: Decodable>(
        decoder: JSONDecoder = JSONDecoder(),
        requestApi: T,
        model: U.Type,
        completion: @escaping (Result<U, RequestError>) -> Void) {
            AF.request(requestApi.baseURL + requestApi.path,
                       method: requestApi.method,
                       parameters: requestApi.parameters,
                       headers: requestApi.headers).response { response in
                guard let _response = response.response else {
                    completion(.failure(.noResponse))
                    return
                }
                switch _response.statusCode {
                case (200...299):
                    do {
                        if let receivedData = response.data {
                            let decodedData = try decoder.decode(model.self, from: receivedData)
                            completion(.success(decodedData))
                        }
                    } catch {
                        completion(.failure(.decode))
                    }
                case (400...499):
                    do {
                        if let receivedError = response.data {
                            let decodedError = try decoder.decode(ErrorModel.self, from: receivedError)
                            completion(.failure(.message(message: decodedError.errorMessage)))
                        } else {
                            if let error = response.error {
                                completion(.failure(.message(message: "[\(_response.statusCode)]  \(error.localizedDescription)")))
                            } else {
                                completion(.failure(.message(message: "[\(_response.statusCode)] No error information")))
                            }
                        }
                    } catch {
                        completion(.failure(.decode))
                    }
                case (500...599):
                    if let serverError = response.error {
                        completion(.failure(.message(message: serverError.localizedDescription)))
                    }
                default:
                    if let error = response.error {
                        completion(.failure(.message(message: error.localizedDescription)))
                    }
                }
            }
        }
    
    func download<T: ApiProtocol>(requestApi: T, completion: @escaping (Result<Data, RequestError>) -> Void) {
        AF.download(NetworkConstants.urlForImage + requestApi.path,
                    method:  requestApi.method,
                    parameters:  requestApi.parameters,
                    headers: requestApi.headers).responseData(completionHandler: { response in
            guard let _response = response.response else {
                completion(.failure(.noResponse))
                return
            }
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.message(message: error.localizedDescription)))
            }
            
        })
        
    }
}
