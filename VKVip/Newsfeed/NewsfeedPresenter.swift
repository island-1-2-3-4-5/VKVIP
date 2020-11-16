//
//  NewsfeedPresenter.swift
//  VKNewsFeed
//
//  Created by Алексей Пархоменко on 15/03/2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogicProtocol {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogicProtocol {
  weak var viewController: NewsfeedDisplayLogicProtocol?
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
  
    switch response {


    case .presentNewsfeed(feed: let feed): // let feed - это ассоциативное значение, которое мы передали ранее
        let cells = feed.items.map { (feedItem) in
            cellViewModel(from: feedItem)
        }
    
        let feedViewModel = FeedViewModel.init(cells: cells)
    
        viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayNewsfeed(feedViewModel: feedViewModel))
    
    }
  }
    
    // эта функция конвертирует данные из сети(FeedResponse) в данные для ячейки
    private func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
        return FeedViewModel.Cell.init(iconUrlString: "",
                                       name: "future name",
                                       date: "future date",
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0))
    }
}
