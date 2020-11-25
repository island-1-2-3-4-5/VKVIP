//
//  String + Height.swift
//  VKVip
//
//  Created by Роман on 25.11.2020.
//

import UIKit
import Foundation


extension String {
    // высчитываем высоту текста при заданной ширине экрана и размера шрифта
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        // считаем ограниченный прямоугольник
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        
        return ceil(size.height) // округляем значение
    }
}
