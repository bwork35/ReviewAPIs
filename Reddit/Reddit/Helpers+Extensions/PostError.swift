//
//  PostError.swift
//  Reddit
//
//  Created by Bryan Workman on 1/16/21.
//

import Foundation

enum PostError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case thrownImageError(Error)
    case noData
    case unableToDecode

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The Server failed to reach the necessary URL."
        case .thrownError(let error):
            return "There was an error: \(error.localizedDescription)"
        case .thrownImageError(let error):
            return "There was an error with an image: \(error.localizedDescription)"
        case .noData:
            return "There was no data found"
        case .unableToDecode:
            return "There was an error when trying to load the data"
        }
    }
} //End of enum
