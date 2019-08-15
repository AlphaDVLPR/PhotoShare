//
//  PhotoTableViewCell.swift
//  PhotoShare
//
//  Created by AlphaDVLPR on 8/15/19.
//  Copyright © 2019 AlphaDVLPR. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
    //Landing Pad
    var photoObjects : PhotoObjects? {
        
        didSet {
            
            updateViews()
        }
    }

    func updateViews() {
        
        guard let item = photoObjects else {
            
            photoImageView.image = nil
            likesLabel.text = ""
            return
        }
        guard let numberOfLikes = photoObjects?.likes else {return}
        likesLabel.text = String(numberOfLikes)
        
        //Fetch image
        PhotoController.fetchImage(item: item) { (fetchedImage) in
            
            //Update UI
            DispatchQueue.main.async {
                self.photoImageView.image = fetchedImage
            }
        }
        
    }
    
}
