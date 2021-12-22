//
//  MyJsonDecode.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 21.12.2021.
//

import Foundation

struct MyJsonDecoder {
    
    static func decodeJson<T:Decodable>(from data: Data,to resultType: T.Type) -> T? {
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            debugPrint(error)
        }
            return nil
    }
    
}
