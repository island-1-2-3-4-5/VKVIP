//
//  NewsfeedInteractor.swift
//  VKNewsFeed
//
//  Created by Алексей Пархоменко on 15/03/2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

// MARK: Сетевые запросы и БД

protocol NewsfeedBusinessLogicProtocol {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogicProtocol {
    
    var presenter: NewsfeedPresentationLogicProtocol?
    var service: NewsfeedService?
    
    
    
    private var revealedPostIds = [Int]()
    private var feedResponce: FeedResponse?
    
    // создаем объект для запросов в NetworkDataFetcher
    private var fetcher: DataFetcherProtocol = NetworkDataFetcher(networking: NetworkService())
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        
        switch request {
        
        case .getNewsfeed:
            fetcher.getFeed { [weak self] (feedResponce) in // [weak self] - используется при  работе с замыканиями для избежания утечки памяти
                self?.feedResponce = feedResponce
                self?.presentFeed()
            }
        case .revealPostIds(let postId):
            revealedPostIds.append(postId)
            presentFeed()
            
        }
    }
    
    private func presentFeed() {
        guard let feedResponce = feedResponce else { return }
        presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsfeed(feed: feedResponce, revealdedPostIds: revealedPostIds))
    }
    
}


