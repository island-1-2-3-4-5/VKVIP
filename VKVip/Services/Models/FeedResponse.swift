//
//  FeedResponse.swift
//  VKVip
//
//  Created by Роман Монахов on 18/11/2020.
//  Copyright © 2020 Роман Монахов. All rights reserved.
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
    let attachments: [Attachment]? // фотографии, видеозаписи, ссылки
}

struct CountableItem: Decodable {
    let count: Int
}

struct Attachment: Codable{
    let photo: Photo? // фотография поста
}

struct Photo: Codable {
    let sizes: [PhotoSize] // у фотки есть размер
    
    var height: Int {
        return getProperSize().height
    }
    
    var width: Int {
        return getProperSize().width
    }
    // адрес изображения для предпросмотра
    var srcBIG: String{
        return getProperSize().url
    }
    
    // из всех фоток нам нужны только с типом х
    private func  getProperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: {$0.type == "x"}) {
            return sizeX
        } else if let fallBackSize = sizes.last{
            // это если вдруг не оказалось типа х
            return fallBackSize
        } else {
            return PhotoSize(type: "wrongImage", url: "wrongImage", width: 0, height: 0)
        }
    }
}
struct PhotoSize: Codable {
    let type: String // тип - формат фото
    let url: String // ссылка на фото
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
