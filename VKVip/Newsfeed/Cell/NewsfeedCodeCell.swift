//
//  NewsfeedCodeCell.swift
//  VKVip
//
//  Created by Роман on 25.11.2020.
//

import Foundation
import UIKit

// Верстаем интерфейс из кода
final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
    
    //MARK: Первый слой
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        // разрешаем компилятору закреплять cardView  на экране
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    
    //MARK: Второй слой
    let topView: UIView = {
        let view = UIView()
        // разрешаем компилятору закреплять cardView  на экране
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        return view
    }()
    
    
    
    let postlabel: UILabel = {
       let label = UILabel()
        
        label.numberOfLines = 0
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = Constants.postLabelFont
        label.textColor = #colorLiteral(red: 0.1534670591, green: 0.1580315232, blue: 0.1530224085, alpha: 1)
        return label
    }()
    
    
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.3819621741, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        return imageView
    }()
    
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return view
    }()
    
    //MARK: Третий слой TopView
    
    let iconImageView: WebImageView = {
       let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        return imageView
    }()
    
    
    let namelabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.1534670591, green: 0.1580315232, blue: 0.1530224085, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    
    
    
    let dateLabel: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.systemFont(ofSize: 12)
         label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
         return label
     }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        overlayFirstLayer() // первый слой
        overlaySecondLayer()
        overlayThrirdLayerOnTopView() // Третий слой на TopView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- FUNCTION

    // передаем данные переменным из протокола FeedCellViewModel
    // Этот метод будем вызывать в NewsfeedViewController в cellForRowAt
    func set(viewModel: FeedCellViewModelProtocol){

        iconImageView.set(imageURL: viewModel.iconUrlString)
        namelabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postlabel.text = viewModel.text
        
        
        
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
    
    
    
    
    //MARK: Третий слой на TopView
    
    func overlayThrirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(namelabel)
        topView.addSubview(dateLabel)
        
        
        
        // iconImageView constraints
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true

        
        // namelabel constraints
        namelabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        namelabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        namelabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        namelabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true

        
        // dateLabel constraints
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
    }
    
    
    //MARK: Второй слой
    func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postlabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        
        // CONSTRAINTS topView
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // CONSTRAINTS postlabel

        
        // CONSTRAINTS postImageView

        
        // CONSTRAINTS bottomView


    }
    
    
    
    //MARK: Первый слой
    func overlayFirstLayer() {
        // Добавляем cardView на экран
        addSubview(cardView)

      //  cardView constraints
        cardView.fillSuperview(padding: Constants.cardInserts) // говорим cardView, что надо заполнить view с такими отступами: снизу 12 а по бокам 8 от contentView
        
    }
    

}
