//
//  ViewController.swift
//  PokeDex
//
//  Created by Bryan Workman on 1/15/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    //MARK: - Properties

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fetchPokemonWith(searchTerm: "25")
    }
  
    //MARK: - Helper Methods
    func fetchPokemonWith(searchTerm: String) {
        PokemonController.fetchPokemonWith(searchTerm: searchTerm.lowercased()) { [weak self] (result) in
            switch result {
            case .success(let pokemon):
                self?.fetchSpriteAndUpdateViewsWith(pokemon: pokemon)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func fetchSpriteAndUpdateViewsWith(pokemon: Pokemon) {
        PokemonController.fetchImageFor(pokemon: pokemon) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.pokeImageView.image = image
                    self?.pokeNameLabel.text = pokemon.name.capitalized
                    self?.pokeIDLabel.text = "\(pokemon.id)"
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }

} //End of class

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        fetchPokemonWith(searchTerm: searchTerm)
    }
} //End of extension

