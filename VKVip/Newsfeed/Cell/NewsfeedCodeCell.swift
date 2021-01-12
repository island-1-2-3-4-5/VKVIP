//
//  NewsfeedCodeCell.swift
//  VKVip
//
//  Created by Роман on 25.11.2020.
//

import Foundation
import UIKit

// Связываем эту ячейку с контроллером
protocol NewsfeedCodeCellDelegate: class {
    func revealPost(for cell: NewsfeedCodeCell)
}


// Верстаем интерфейс из кода
final class NewsfeedCodeCell: UITableViewCell {
    
    
    static let reuseId = "NewsfeedCodeCell"
    
    weak var delegate: NewsfeedCodeCellDelegate?
    
    //MARK: Первый слой
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        // разрешаем компилятору закреплять cardView  на экране
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    
    //MARK: Второй слой
    let topView: UIView = {
        let view = UIView()
        // разрешаем компилятору закреплять cardView  на экране
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    //    let postlabel: UILabel = {
    //       let label = UILabel()
    //        label.numberOfLines = 0
    //        label.font = Constants.postLabelFont
    //        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
    //        return label
    //    }()
    
    let postlabel: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = true
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding)
        // позволяем видеть ссылки
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        return textView
    }()
    
    // кнопка раскрытия большого текста
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4012392163, green: 0.6231879592, blue: 0.8316264749, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return imageView
    }()
    
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: Третий слой TopView
    
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        return label
    }()
    
    
    
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    
    
    //MARK: Третий слой на bottomView
    
    
    // Все кнопки хранятся в отдельном view
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Четвертый слой на bottomView
    
    let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping //Линии не выходят за край текстового контейнера.
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    
    //Переиспользование ячеек
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // тк iconImageView зависит от высоты вью, то делаем закругление на основе этих данных
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
        
        overlayFirstLayer() // первый слой
        overlaySecondLayer() // второй слой
        overlayThirdLayerOnTopView() // третий слой на topView
        overlayThirdLayerOnBottomView() // третий слой на bottomView
        overlayFourthLayerOnBottomViewViews() // четвертый слой на bottomViewViews
    }
    
    
    
    
    //MARK:- FUNCTION
    
    @objc func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
    }
    
    
    //MARK: SET
    // передаем данные переменным из протокола FeedCellViewModel
    // Этот метод будем вызывать в NewsfeedViewController в cellForRowAt
    func set(viewModel: FeedCellViewModelProtocol){ // МОДЕЛЬ ДОЛЖНА БЫТЬ ПОДПИСАНА ПОД ПРОТОКОЛ FeedCellViewModelProtocol
        
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postlabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        // В получаемой модели содержатся размеры фотографий, от них мы и будем регулировать размер вью
        postlabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachementFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        
        if let photoAttachment = viewModel.photoAttachment {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
    
    
    //MARK: Четвертый слой
    private func overlayFourthLayerOnBottomViewViews() {
        // заполняем вьюшки
        likesView.addSubview(likesImage) // изображение + текст
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        // эта функция работает с каждой группой элементов и фиксирует внутри себя
        helpInFourthLayer(view: likesView, imageView: likesImage, label: likesLabel)
        helpInFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        helpInFourthLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        helpInFourthLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
    }
    
    private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        
        // imageView constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true // отцентровываем изображение
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        
        // label constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true // отцентровываем текст
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    
    //MARK: Третий слой на bottomView
    private func overlayThirdLayerOnBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        // likesView constraints
        likesView.anchor(top: bottomView.topAnchor, // верх к верху
                         leading: bottomView.leadingAnchor, // левая граница к левой
                         bottom: nil, // снизу и справа не привязываем
                         trailing: nil,
                         // paddings - убираем
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        // commentsView constraints
        commentsView.anchor(top: bottomView.topAnchor,
                            leading: likesView.trailingAnchor,
                            bottom: nil,
                            trailing: nil,
                            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        // sharesView constraints
        sharesView.anchor(top: bottomView.topAnchor,
                          leading: commentsView.trailingAnchor,
                          bottom: nil,
                          trailing: nil,
                          size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        // viewsView constraints
        viewsView.anchor(top: bottomView.topAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: bottomView.trailingAnchor,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
    }
    
    
    
    //MARK: Третий слой на TopView
    
    func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        
        
        // iconImageView constraints
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // nameLabel constraints
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
        
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
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        
        // topView constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        
        // postlabel constraints
        // не нужно, так как размеры задаются динамически
        
        // moreTextButton constraints
        // не нужно, так как размеры задаются динамически
        
        // postImageView constraints
        // не нужно, так как размеры задаются динамически
        
        // bottomView constraints
        // не нужно, так как размеры задаются динамически
    }
    
    
    
    //MARK: Первый слой
    func overlayFirstLayer() {
        // Добавляем cardView на экран
        contentView.addSubview(cardView)
        
        //  cardView constraints
        cardView.fillSuperview(padding: Constants.cardInserts) // говорим cardView, что надо заполнить view с такими отступами: снизу 12 а по бокам 8 от contentView
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
