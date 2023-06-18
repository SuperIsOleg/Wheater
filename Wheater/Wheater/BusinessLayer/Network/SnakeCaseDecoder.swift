//
//  SnakeCaseDecoder.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import Foundation

final class SnakeCaseDecoder: JSONDecoder {
    override init() {
        super.init()
        self.keyDecodingStrategy = .convertFromSnakeCase
    }
}
