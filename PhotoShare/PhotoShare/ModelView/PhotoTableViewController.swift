//
//  PhotoTableViewController.swift
//  PhotoShare
//
//  Created by AlphaDVLPR on 8/15/19.
//  Copyright © 2019 AlphaDVLPR. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController, UISearchBarDelegate {

    //Outlets
    @IBOutlet weak var searchbar: UISearchBar!
    
    var items: [PhotoObjects] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchbar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Make sure to force unwrap it which allows you to grab the photo object from the landing pad
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell else {return UITableViewCell()}

        // Configure the cell...

        let item = items[indexPath.row]
        
        cell.photoObjects = item
        
        return cell
    }

    //SEARCH BAR
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchTerm = searchbar.text,
        !searchTerm.isEmpty else {return}

        PhotoController.fetchItem(searchTerm: searchTerm) { (photos) in
            self.items = photos
        
        //then update UI
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
}
