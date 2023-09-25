//
//  Constants.swift
//  CollectionProfiles
//
//  Created by Анастасия Рыбакова on 20.09.2023.
//

import UIKit

// 1.2 -> 2.1
// Задаем константы, которые будем использовать при верстке интерфейса

// Отступы и размеры для ячеек коллекции
enum LayoutConstant {
    static let spacing: CGFloat = 16.0
    static let itemHeight: CGFloat = 300.0
    static let secondSpacing: CGFloat = 30.0
}

// Константы, которые будем использовать при верстке ячейки
enum CellConstants {
    static let contentViewRadius: CGFloat = 5.0
    static let imageHeight: CGFloat = 180.0
    static let horizontalPadding: CGFloat = 16.0
    static let verticalPadding: CGFloat = 8.0
    static let verticalSpacing: CGFloat = 4.0
}

enum SecondVCConstants {
    static let imageHeight: CGFloat = 300.0
    static let verticalPadding: CGFloat = 50.0
    static let spacing: CGFloat = 20.0
}

extension UILabel {
    
    convenience init(color: UIColor, size: CGFloat) {
        self.init()
        self.textAlignment = .center
        self.numberOfLines = 0
        self.textColor = color
        self.font = .systemFont(ofSize: size)
    }
}
