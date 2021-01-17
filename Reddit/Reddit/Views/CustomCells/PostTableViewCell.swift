//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Bryan Workman on 1/16/21.
//

import UIKit

protocol  PresentErrorToUserDelegate: class {
    func presentErrorToUser(error: LocalizedError)
}

class PostTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postUpsLabel: UILabel!
    
    //MARK: - Properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: PresentErrorToUserDelegate?
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let post = post else {return}
        postTitleLabel.text = post.title
        postUpsLabel.text = "Upvotes: \(post.ups)"
        postImageView.image = nil
        
        PostController.fetchThumbnailFor(post: post) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.postImageView.image = image
                case .failure(let error):
                    self?.delegate?.presentErrorToUser(error: error)
                }
            }
        }
    }
 
} //End of class
