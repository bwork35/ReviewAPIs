//
//  PostController.swift
//  Reddit
//
//  Created by Bryan Workman on 1/16/21.
//

import Foundation
import UIKit.UIImage

struct StringConstants {
    fileprivate static let baseURL = "https://www.reddit.com"
    fileprivate static let rComponentString = "r"
    fileprivate static let funnyComponentString = "funny"
    fileprivate static let jsonExtensionString = "json"
    //https://www.reddit.com/r/funny.json
}

class PostController {
    
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        
        guard let baseURL = URL(string: StringConstants.baseURL) else {return completion(.failure(.invalidURL))}
        let rcomponentURL = baseURL.appendingPathComponent(StringConstants.rComponentString)
        let funnyURL = rcomponentURL.appendingPathComponent(StringConstants.funnyComponentString)
        let finalURL = funnyURL.appendingPathExtension(StringConstants.jsonExtensionString)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelDict = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let secondLevelDict = topLevelDict.data
                let thirdLevelArray = secondLevelDict.children
                
                var placeholderArray: [Post] = []
                for thirdLevelObject in thirdLevelArray {
                    let post = thirdLevelObject.data
                    placeholderArray.append(post)
                }
                
                return completion(.success(placeholderArray))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchThumbnailFor(post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        
        guard let thumbnailURL = post.thumbnail else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: thumbnailURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownImageError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            return completion(.success(image))
        }.resume()
    }
    
} //End of class
