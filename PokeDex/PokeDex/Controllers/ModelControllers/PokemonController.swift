//
//  PokemonController.swift
//  PokeDex
//
//  Created by Bryan Workman on 1/15/21.
//

import UIKit

//https://pokeapi.co/api/v2/pokemon/{id or name}/

class PokemonController {
    
    static func fetchPokemonWith(searchTerm: String, completion: @escaping (Result<Pokemon, PokeError>) -> Void) {
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2") else {return completion(.failure(.invalidURL))}
        let pokemonEndPoint = "pokemon"
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndPoint)
        let finalURL = pokemonURL.appendingPathComponent(searchTerm)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImageFor(pokemon: Pokemon, completion: @escaping (Result<UIImage, PokeError>) -> Void) {
        let finalURL = pokemon.sprites.classicSpriteURL
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            return completion(.success(image))
        }.resume()
    }
    
} //End of class
