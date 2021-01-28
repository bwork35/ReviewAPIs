//
//  ArtistListTableViewController.swift
//  ArtistSearch00
//
//  Created by Bryan Workman on 1/27/21.
//

import UIKit

class ArtistListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var artists: [Artist] = []
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath)

        let artist = artists[indexPath.row]
        cell.textLabel?.text = artist.artistName
        cell.detailTextLabel?.text = artist.artistTwitterURL
       
        return cell
    }

} //End of class

extension ArtistListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        ArtistController.fetchArtist(with: searchTerm) { (result) in
            switch result {
            case .success(let artistObjects):
                DispatchQueue.main.async {
                    self.artists = artistObjects
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription ?? "There was an error fetching artists.")
            }
        }
    }
} //End of extension
