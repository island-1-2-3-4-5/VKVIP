//
//  WebImageView.swift
//  VKVip
//
//  Created by Роман on 19.11.2020.
//

import UIKit

// этот класс привязан к UIImageView в NewsfeedCell
class WebImageView: UIImageView {
    
    func set(imageURL: String?){
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return
        }
        
        
        //Проверка на кэш изображения
        if let cachedResponce = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            //если такое изображение уже имеется в нашем кэше, то тогда
            self.image = UIImage(data: cachedResponce.data)
//            print("\(#function) -  from cache")
            return
        } // если такого изображения нет в кэше, то изображение необходимо поместить туда
        
        
//        print("\(#function) -  from internet")
        // загружаем изображени я
        let dataTask = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in // [weak self] - чтобы избежать утечек памяти
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    // делаем запись в кэш
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    
    // функция записи изображений в кэш
    private func handleLoadedImage(data: Data, response: URLResponse){
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        
    }
    
}
