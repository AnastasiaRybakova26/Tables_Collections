//
//  Profile.swift
//  CollectionProfiles
//
//  Created by Анастасия Рыбакова on 20.09.2023.
//

import Foundation


// 1.1 -> 1.2
// Создаем структуру данных, которыми будем заполнять ячейки коллекции
struct Profile {
    let name: String
    let location: String
    let imageName: String
    let subject: String
    
    static func makeMockData() -> [Self] {
        [Profile(name: "Thor Ivanov", location: "Boston", imageName: "astronomy", subject: "Astronomy"),
         Profile(name: "Mike Popper", location: "Albequerque", imageName: "basketball", subject: "Basketball"),
         Profile(name: "Walter White", location: "New Mexico", imageName: "chemistry", subject: "Chemistry"),
         Profile(name: "Sam Brothers", location: "California", imageName: "geography", subject: "Geography"),
         Profile(name: "Chopin", location: "Norway", imageName: "geometry", subject: "Geometry"),
         Profile(name: "Castles Jones", location: "UK", imageName: "history", subject: "history"),
         Profile(name: "Dr. Johnson", location: "Australia", imageName: "microscope", subject: "Biology"),
         Profile(name: "Tom Hanks", location: "Bel Air", imageName: "theater", subject: "Theater"),
         Profile(name: "Roger Federer", location: "Switzerland", imageName: "trophy", subject: "trophy"),
         Profile(name: "Elon Frod", location: "San Francisco", imageName: "graduate", subject: "graduate"),
        ]
    }
}
