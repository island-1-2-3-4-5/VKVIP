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
    var moreTextButtonFrame: CGRect
    var attachementFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    
}


protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModelProtocol?, isFullSizedPost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    //  свойство отвечающее за ширину экрана
    private let screenWidth: CGFloat
    
    // в инициализаторе инициализируем значение по умолчанию, которое выбирает 
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    
    
    // вызывается в cellViewModel через протокол
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModelProtocol?, isFullSizedPost: Bool) -> FeedCellSizes {
        
        // если эта переменная true, то будем в нашем посте отображать кнопку показать больше
        var showMoreTextButton = false
        
        // чтобы точно вычесть размеры cardView, надо вычесть из contentView, размером с шириу экрана, отступы
        let cardViewWidth = screenWidth - Constants.cardInserts.left - Constants.cardInserts.right
        
        
        //MARK:- PostLabelFrame
        // расположение текста
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInserts.left,
                                                    y: Constants.postLabelInserts.top), // origin - координаты (x = 8, y = 52)
                                    size: CGSize.zero)
        
        
        // размер текста если он существует
        if let text = postText, !text.isEmpty {
            
            // считаем ширину и высоту текста
            let width = cardViewWidth - Constants.postLabelInserts.left - Constants.postLabelInserts.right // Ширина postLabel
            var height = text.height(width: width, font: Constants.postLabelFont) // пишем функцию height в extension для string в HELPERS
            
            
            
            // максимальная высота которую можно отображать до кнопки скрыть
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            
            
            // если есть превышение по строкам, то показываем кнопку
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        
        
        // MARK: - MoreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize) // размер и расположение
        
        
        //MARK: - AttachementFrame
        
        // если текстовое поле развно 0, то фотография будет начинаться от верха иначе от низа кнопки "показать больше" + отступ
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInserts.top : moreTextButtonFrame.maxY + Constants.postLabelInserts.bottom
        // расположение фотки
        var attachementFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero) // size - вычисляем ниже
        
        // размер фотки если она существует
        if let attachment = photoAttachment {
            // вычисляем высоту на основе ширины экрана с помощью заданного соотношения сторон
            let ratio = Float(attachment.height) / Float(attachment.width)
            attachementFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * CGFloat(ratio))
        }
        
        
        
        //MARK:- BottomViewFrame
        // расположение элементов над bottomView
        let bottomViewTop = max(postLabelFrame.maxY, attachementFrame.maxY)
        
        // расположение bottomView
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0,
                                                     y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth,
                                                  height: Constants.bottomViewHeight))
        
        
        
        //MARK:- TotalHeight
        
        // bottomViewFrame.maxY - самый нижний элемент, Constants.cardInserts.bottom - отступ снизу
        let totalHeight = bottomViewFrame.maxY + Constants.cardInserts.bottom
        
        
        return Sizes(postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachementFrame: attachementFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
    
}
