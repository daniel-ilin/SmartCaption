//
//  QuoteService.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 23.12.2021.
//

import Foundation

struct QuoteService {
    
    static func getQuotesForTags(_ tagsArray: [ImageTag], completion: @escaping((Quote) -> Void)) {
        
        let defaultSession = URLSession(configuration: .default)
        
        let tagsStringArray = tagsArray.map { $0.imageTag }
        let tags = tagsStringArray.joined(separator: " ")
        
        print("DEBUG: Tags are \(tags)")
        
        var urlComponents = URLComponents(string: "http://api.quotable.io/search/quotes")
        let queryItem = URLQueryItem(name: "query", value: "\(tags)")
        urlComponents?.queryItems = [queryItem]
        
        guard let url = urlComponents?.url else { return }        
        
        print("DEBUG: url is \(url)")
        
        let dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DataTask error: " +
                      error.localizedDescription + "\n")
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                guard let responseQuote = MyJsonDecoder.decodeJson(from: data, to: QuoteResponseData.self) else { return }
                var quote: Quote?
                if responseQuote.count > 0 {
                    let randromNum = Int.random(in: 0...(responseQuote.count-1))
                    quote = Quote(quoteText: responseQuote.results[randromNum].content, author: responseQuote.results[randromNum].author)
                } else {
                    quote = Quote(quoteText: "Unfortunately, we could not find a quote", author: "Author")
                }
                completion(quote!)
            }
        }
        
        dataTask.resume()
    }
    
}
