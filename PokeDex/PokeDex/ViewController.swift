//
//  ViewController.swift
//  PokeDex
//
//  Created by Bryan Workman on 1/15/21.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
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
    }
  
    //MARK: - Helper Methods
    func search() {
        
    }

} //End of class

