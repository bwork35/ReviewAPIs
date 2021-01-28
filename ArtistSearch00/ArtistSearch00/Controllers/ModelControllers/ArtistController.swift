//
//  ArtistController.swift
//  ArtistSearch00
//
//  Created by Bryan Workman on 1/27/21.
//

import Foundation

class ArtistController {
    
    // https://api.musixmatch.com/ws/1.1/artist.search?q_artist={searchTerm} + apiKeyQ
    
    // https://api.musixmatch.com/ws/1.1/artist.search?q_artist=Kanye&apikey=c2dfd942d236a20c4d0dba3c3bb12d75
    
    // c6b0685ce529c520dd488925d17fe56d
    
    static let baseURL = URL(string: "https://api.musixmatch.com/ws/1.1")
    static let artistSearchComponent = "artist.search"
    static let qArtistQueryString = "q_artist"
    static let apiKeyString = "apikey"
    static let apiKeyValue = "c2dfd942d236a20c4d0dba3c3bb12d75"
    
    static func fetchArtist(with searchTerm: String, completion: @escaping (Result<[ArtistObject], ArtistError>) -> Void) {
        
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let artistSearchURL = baseURL.appendingPathComponent(artistSearchComponent)
        
        var components = URLComponents(url: artistSearchURL, resolvingAgainstBaseURL: true)
        let artistSearchQuery = URLQueryItem(name: qArtistQueryString, value: searchTerm)
        let apiKeyQuery = URLQueryItem(name: apiKeyString, value: apiKeyValue)
        components?.queryItems = [artistSearchQuery, apiKeyQuery]
        
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let artistObjects = topLevelObject.message.body.artistList
                completion(.success(artistObjects))
            } catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
} //End of class
