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
    
    var bottomView: CGRect
    var totalHeight: CGFloat
}


struct Constants {
    static let cardInserts = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
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
    

    
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModelProtocol?) -> FeedCellSizes {
        
        
        let cardViewWidth = screenWidth
        
        
        return Sizes(postLabelFrame: CGRect.zero,
                     attachementFrame: CGRect.zero,
                     bottomView: CGRect.zero,
                     totalHeight: 300)
    }
 
}
