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
    case .presentNewsfeed(feed: let feed): // let feed - это ассоциативное значение, которое мы передали ранее
        
        let cells = feed.items.map { (feedItem) in
            // эта функция конвертирует данные из сети(FeedResponse) в данные для ячейки
            cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
            
        }
    // инициализируем объект модели
        let feedViewModel = FeedViewModel.init(cells: cells) // у структур есть встроенный инициализатор
    
        //MARK: Высылаем данные
        viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayNewsfeed(feedViewModel: feedViewModel))
    
    }
  }
    
    
    
    
    //MARK: - Работа с ячейками
    // эта функция конвертирует данные из сети(FeedResponse) в данные для ячейки
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        // Создаем объект профайла для заполнения названия поста, даты создания и группы
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let photoAttachement = self.photoAttachement(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        return FeedViewModel.Cell.init(iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachement: photoAttachement)
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
    
    
    
    private func photoAttachement(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachement? {
        guard let photos = feedItem.attachments?.compactMap({ (attachement) in
            attachement.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        
        return FeedViewModel.FeedCellPhotoAttachement.init(photoUrlString: firstPhoto.srcBIG, height: firstPhoto.height, width: firstPhoto.width)
    }
}
