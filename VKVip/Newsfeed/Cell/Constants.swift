//
//  Constants.swift
//  VKVip
//
//  Created by Роман on 26.11.2020.
//

import UIKit


//  в этой структуре фиксируются отступы от вью
struct Constants {
    static let cardInserts = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8) // говорим cardView, что надо отступить снизу 12 а по бокам 8 от contentView
    static let topViewHeight: CGFloat = 36 // высота topView
    static let postLabelInserts = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8) // отступы postLabel с учетом topView
    static let postLabelFont = UIFont.systemFont(ofSize: 15) // системный размер шрифта
    static let bottomViewHeight: CGFloat = 44
}
