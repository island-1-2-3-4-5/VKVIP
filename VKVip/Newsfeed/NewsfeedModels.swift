//
//  FeedResponse.swift
//  VKVip
//
//  Created by Роман on 24.11.2020.
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
        var photoAttachment: FeedCellPhotoAttachmentViewModelProtocol?
        var sizes: FeedCellSizes


    }
    
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModelProtocol {
        var photoUrlString: String?
        var height: Int
        var width: Int
            
    }
    
    
    // в новостной ленте присутствует не одна ячейка, поэтомк делаем массив
    let cells: [Cell]
    
}
