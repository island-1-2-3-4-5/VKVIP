//
//  NewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Алексей Пархоменко on 19/03/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
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
    
}

class NewsfeedCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCell"
    
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postlabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var shareslabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    }
    
}
