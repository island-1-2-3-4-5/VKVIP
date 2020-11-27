//
//  Constants.swift
//  VKVip
//
//  Created by Роман on 26.11.2020.
//

import UIKit


//  в этой структуре фиксируются отступы от вью и размеры
struct Constants {
    static let cardInserts = UIEdgeInsets(top: 4, left: 8, bottom: 8, right: 8) // говорим cardView, что надо отступить снизу 12 а по бокам 8 от contentView
    static let topViewHeight: CGFloat = 36 // высота topView
    static let postLabelInserts = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8) // отступы postLabel с учетом topView
    static let postLabelFont = UIFont.systemFont(ofSize: 15) // системный размер шрифта
    static let bottomViewHeight: CGFloat = 44 //  Высота bottomView
    
    
    
    static let bottomViewViewHeight: CGFloat = 44 // Высота view в bottomView
    static let bottomViewViewWidth: CGFloat = 80 // ширина view в bottomView
    static let bottomViewViewsIconSize: CGFloat = 24 // размер иконок во view в bottomView
    
    static let minifiedPostLimitLines: CGFloat = 8 // если текст превышает 8 строк, то показываем кнопку
    static let minifiedPostLines: CGFloat = 6 // если кнопка высвечивается, то отображаем 6 строк
    
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
}
