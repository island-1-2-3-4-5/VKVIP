//
//  FeedResponse.swift
//  VKVip
//
//  Created by Роман Монахов on 18/11/2020.
//  Copyright © 2020 Роман Монахов. All rights reserved.
//

import Foundation
import UIKit


protocol FeedCellViewModelProtocol {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachment: FeedCellPhotoAttachmentViewModelProtocol? { get }
    
    // свойство которое будет хранить размеры для отрисовки вью
    var sizes: FeedCellSizes { get }
    
}

//   этот протокол описывает размеры вью
protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachementFrame: CGRect { get }
    
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get } // надо для heightForRowAt
    
}

// несет в себе данные по фотографиям
protocol FeedCellPhotoAttachmentViewModelProtocol {
    var photoUrlString: String? { get }
    var height: Int { get }
    var width: Int { get }
}

class NewsfeedCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postlabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var shareslabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    //Переиспользование ячеек
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        
        backgroundColor = .clear
        selectionStyle = .none
        
    }
    
    
    
    
    // передаем данные переменным из протокола FeedCellViewModel
    // Этот метод будем вызывать в NewsfeedViewController в cellForRowAt
    func set(viewModel: FeedCellViewModelProtocol){
        iconImageView.set(imageURL: viewModel.iconUrlString)
        namelabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postlabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        shareslabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        
        // В получаемой модели содержатся размеры фотографий, от них мы и будем регулировать размер вью
        postlabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachementFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if let photoAttachment = viewModel.photoAttachment {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
    
}


extension UIView{
    
    
}
