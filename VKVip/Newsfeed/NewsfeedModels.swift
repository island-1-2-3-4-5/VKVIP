//
//  NewsfeedModels.swift
//  VKNewsFeed
//
//  Created by Алексей Пархоменко on 15/03/2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

enum Newsfeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsfeed
        
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsfeed(feed: FeedResponse) // когда вызываем этот кейс, в качестве параметра у него будет идти объект типа FeedResponse из сетевого запроса
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsfeed(feedViewModel: FeedViewModel) // тут в качестве аасоциативного значения будет идти модель заполнения ячейки, которую описали ниже
      }
    }
  }
  
}


struct FeedViewModel {
    // эта структура должна соответствовать протоколу для заполения ячейки
    struct Cell: FeedCellViewModelProtocol {
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
    }
    
    // в новостной ленте присутствует не одна ячейка, поэтомк делаем массив
    let cells: [Cell]
    
}
