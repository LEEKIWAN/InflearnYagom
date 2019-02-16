//
//  FriendTableViewCell.swift
//  YaGomProject
//
//  Created by 이기완 on 10/02/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

protocol FriendTableViewCellDelegate {
    func friendCellStarredStateChanged(_ sender: FriendTableViewCell)
}

class FriendTableViewCell: UITableViewCell {

    var delegate: FriendTableViewCellDelegate?
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    
    
    @IBOutlet weak var starButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onStarTouched(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if let delegate = self.delegate {
            delegate.friendCellStarredStateChanged(self)
        }
    }
}


// MARK: - Configure Cell
extension FriendTableViewCell {
    
    func configure(friend: Person, tableView: UITableView, indexPath: IndexPath) {
        
        self.nameLabel.text = friend.name.full
        self.nationalityLabel.text = friend.nationality
        self.cellLabel.text = friend.cell
        self.starButton.isSelected = Person.bestFriends.contains(friend)
        
        self.profileImageView.image = placeHolderImage
        
        Request.image(friend.pictureURL.thumbnail, completion: { (image: UIImage?) in
            
            DispatchQueue.main.async {
                
                guard let cell: FriendTableViewCell = tableView.cellForRow(at: indexPath) as? FriendTableViewCell else {
                    return
                }
                
                cell.profileImageView.image = image
            }
        })
    }
}
