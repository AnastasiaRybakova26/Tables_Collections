//
//  UIKit+Extension.swift
//  CollectionNews
//
//  Created by Анастасия Рыбакова on 25.09.2023.
//

import Foundation

// Расширение, добавляет строке метод создания рандомного текста заданной длины
extension String {
    
    static func random(lenght: Int) -> Self {
        
        let bace = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var randomString: String = ""
        
        for _ in 0 ..< lenght {
            let randomNumber = Int.random(in: 0..<bace.count)
            randomString += "\(bace[bace.index(bace.startIndex, offsetBy: randomNumber)])"
        }
        
        return randomString
    }
    
}
