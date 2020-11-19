//
//  FeedResponse.swift
//  VKNewsFeed
//
//  Created by Алексей Пархоменко on 08/03/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}

struct CountableItem: Decodable {
    let count: Int
}

struct Attachment: Codable{
    let photo: Photo?
}

struct Photo: Codable {
    let sizes: [PhotoSize]
}
struct PhotoSize: Codable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

protocol ProfileRepresentableProtocol {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Codable, ProfileRepresentableProtocol {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    
    var name: String { return firstName + " " + lastName }
    var photo: String { return photo100 }
}

struct Group: Codable, ProfileRepresentableProtocol {
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String { return photo100 }
}
