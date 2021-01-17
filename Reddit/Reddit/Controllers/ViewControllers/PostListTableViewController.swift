//
//  PostListTableViewController.swift
//  Reddit
//
//  Created by Bryan Workman on 1/16/21.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    //MARK: - Properties
    var posts: [Post] = []
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    
    //MARK: - Helper Methods
    func fetchPosts() {
        PostController.fetchPosts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                case .failure(let error):
                    print("error -- \(error)")
                }
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell()}

        let post = posts[indexPath.row]
        cell.post = post
        cell.delegate = self
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //End of class

extension PostListTableViewController: PresentErrorToUserDelegate {
    func presentErrorToUser(error: LocalizedError) {
        self.presentErrorToUser(localizedError: error)
    }
} //End of extension
