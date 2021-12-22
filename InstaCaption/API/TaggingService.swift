//
//  TaggingService.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 20.12.2021.
//

import Foundation
import UIKit

struct TaggingService {
    
    static func getTagsForImageId(_ id: String, completion: @escaping(ImageData)->Void) {
        
        let defaultSession = URLSession(configuration: .default)
        
        var urlComponents = URLComponents(string: "https://api.imagga.com/v2/tags")
        let query = URLQueryItem(name: "image_upload_id", value: id)
        urlComponents?.queryItems = [query]
        urlComponents?.user = TAG_API_USERNAME
        urlComponents?.password = TAG_API_PASSWORD
        guard let url = urlComponents?.url else { return }
        
        let dataTask =
        defaultSession.dataTask(with: url) { data, response, error in            
            if let error = error {
                print("DataTask error: " +
                      error.localizedDescription + "\n")
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                guard let imageData = MyJsonDecoder.decodeJson(from: data, to: ImageData.self) else { return }
                completion(imageData)
            }
        }
        dataTask.resume()
    }
    
}
