//
//  ImageUploader.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 20.12.2021.
//

import UIKit

struct ImageUploader {
    
        static func uploadImage(_ image: UIImage, completion: @escaping(String) -> Void) {
    
            let defaultSession = URLSession(configuration: .default)
            let imageData: Data = image.pngData()!
    
            let request = MultipartFormDataRequest(url: URL(string: "https://\(TAG_API_USERNAME):\(TAG_API_PASSWORD)@api.imagga.com/v2/uploads")!)
               request.addDataField(named: "image", data: imageData, mimeType: "png")
            
            let dataTask = defaultSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Data task failed - \(error)")
                } else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {                    
                    let parsedResponse = MyJsonDecoder.decodeJson(from: data, to: ResponseData.self)
                    guard let id = parsedResponse?.result.uploadID else { return }                    
                    completion(id)
                }
            }
            
            dataTask.resume()
        }
    
}
