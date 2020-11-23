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
    var photoAttachement: FeedCellPhotoAttachementViewModelProtocol? { get }
    
}

// несет в себе данные по фотографиям
protocol FeedCellPhotoAttachementViewModelProtocol {
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
        
        if let photoAttachement = viewModel.photoAttachement {
            postImageView.set(imageURL: photoAttachement.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
    
}
