//
//  NewsFeedCellLayoutCalculator.swift
//  VKVip
//
//  Created by Роман on 24.11.2020.
//

import UIKit

// этот класс нужен для подсчета размеров ячейки в таблице в зависимости от размера изображения и размера текста



struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachementFrame: CGRect
    
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

//  в этой структуре фиксируются отступы от вью
struct Constants {
    static let cardInserts = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8) // говорим cardView, что надо отступить снизу 12 а по бокам 8 от contentView
    static let topViewHeight: CGFloat = 36 // высота topView
    static let postLabelInserts = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8) // отступы postLabel с учетом topView
    static let postLabelFont = UIFont.systemFont(ofSize: 15) // системный размер шрифта
    static let bottomViewHeight: CGFloat = 44
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModelProtocol?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
 
    //  свойство отвечающее за ширину экрана
    private let screenWidth: CGFloat
    
    // в инициализаторе инициализируем значение по умолчанию, которое выбирает 
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    

    
    // вызывается в cellViewModel через протокол
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModelProtocol?) -> FeedCellSizes {
        
        // чтобы точно вычесть размеры cardView, надо вычесть из contentView, размером с шириу экрана, отступы
        let cardViewWidth = screenWidth - Constants.cardInserts.left - Constants.cardInserts.right
        
        
        //MARK: Работа с postLabelFrame
        // расположение текста
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInserts.left,
                                                    y: Constants.postLabelInserts.top), // origin - координаты (x = 8, y = 52)
                                    size: CGSize.zero)
        
        
        // размер текста если он существует
        if let text = postText, !text.isEmpty {
            
            // считаем ширину и высоту текста
            let width = cardViewWidth - Constants.postLabelInserts.left - Constants.postLabelInserts.right // Ширина postLabel
            let height = text.height(width: width, font: Constants.postLabelFont) // пишем функцию height в extension для string в HELPERS
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        
        
        
        //MARK: Работа с attachementFrame
        
        // если текстовое поле развно 0, то фотография будет начинаться от верха иначе от низа текстового поля + отступ
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInserts.top : postLabelFrame.maxY + Constants.postLabelInserts.bottom
        // расположение фотки
        var attachementFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero) // size - вычисляем ниже
        
        // размер фотки если она существует
        if let attachment = photoAttachment {
            // вычисляем высоту на основе ширины экрана с помощью заданного соотношения сторон
            let ratio = Float(attachment.height) / Float(attachment.width)
            attachementFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * CGFloat(ratio))
        }
        
        
        
        //MARK: Работа с bottomViewFrame
        // расположение элементов над bottomView
        let bottomViewTop = max(postLabelFrame.maxY, attachementFrame.maxY)

        // расположение bottomView
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0,
                                                     y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth,
                                                  height: Constants.bottomViewHeight))
        
        
        
        //MARK: Работа с totalHeight

        // bottomViewFrame.maxY - самый нижний элемент, Constants.cardInserts.bottom - отступ снизу
        let totalHeight = bottomViewFrame.maxY + Constants.cardInserts.bottom
        
        
        return Sizes(postLabelFrame: postLabelFrame, // postLabelFrame - возвращаем в ячейку NewsfeedCell в функцию set
                     attachementFrame: attachementFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
 
}
