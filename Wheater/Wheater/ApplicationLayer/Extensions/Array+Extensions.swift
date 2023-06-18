//
//  Array+Extensions.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
