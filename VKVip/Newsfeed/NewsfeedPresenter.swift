//
//  FeedResponse.swift
//  VKVip
//
//  Created by Роман Монахов on 18/11/2020.
//  Copyright © 2020 Роман Монахов. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogicProtocol {
    func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogicProtocol {
    weak var viewController: NewsfeedDisplayLogicProtocol?
    
    
    
    // создаем и инициализируем обьект, подписанный под протокол, с помощью которого мы смогли бы считать размер ячеек
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    
    // Создаем dateFORMATTER
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    
    
    //MARK: - presentData
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        
        
        switch response {
        
        //MARK: Сюда приходят данные
        case .presentNewsfeed(feed: let feed, let revealdedPostIds): // let feed - это ассоциативное значение, которое мы передали ранее
            
            let cells = feed.items.map { (feedItem) in
                // эта функция конвертирует данные из сети(FeedResponse) в данные для ячейки
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealdedPostIds: revealdedPostIds)
                
            }
            // инициализируем объект модели
            let feedViewModel = FeedViewModel.init(cells: cells) // у структур есть встроенный инициализатор
            
            //MARK: Высылаем данные
            viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayNewsfeed(feedViewModel: feedViewModel))
            
        }
    }
    
    
    
    
    //MARK: - Работа с ячейками
    // эта функция конвертирует данные из сети(FeedResponse) в данные для ячейки
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealdedPostIds: [Int]) -> FeedViewModel.Cell {
        // Создаем объект профайла для заполнения названия поста, даты создания и группы
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let photoAttachment = self.photoAttachment(feedItem: feedItem) // заполняем фотки
        // генерируем размеры вью исходя из текста и размеров изображения
        //        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachment: photoAttachment)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = revealdedPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        
        //let isFullSized = revealdedPostIds.contains(feedItem.postId) // краткий вариант записи
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachment: photoAttachment, isFullSizedPost: isFullSized)
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachment: photoAttachment,
                                       sizes: sizes)
    }
    
    
    
    
    // Определяем кто перед нами, группа или пользователь
    private func profile(for sourseId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentableProtocol {
        let profilesOrGroups: [ProfileRepresentableProtocol] = sourseId >= 0 ? profiles : groups // если id  отрицательный. то перед нами пользователь иначе группа
        let normalSourseId = sourseId >= 0 ? sourseId : -sourseId
        let profileRepresentable = profilesOrGroups.first { (myProfileRepesentable) -> Bool in
            myProfileRepesentable.id == normalSourseId
        }
        return profileRepresentable!
    }
    
    
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachement) in
            attachement.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG, height: firstPhoto.height, width: firstPhoto.width)
    }
}
