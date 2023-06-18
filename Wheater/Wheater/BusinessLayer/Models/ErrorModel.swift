//
//  ErrorModel.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import Foundation

struct ErrorModel: Codable {
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case errorMessage = "ErrorMessage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
    }
}
