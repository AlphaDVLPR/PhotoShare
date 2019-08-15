//
//  PhotoController.swift
//  PhotoShare
//
//  Created by AlphaDVLPR on 8/15/19.
//  Copyright © 2019 AlphaDVLPR. All rights reserved.
//

import Foundation
import UIKit.UIImage

class PhotoController {
    
    //Fetch Item
    static func fetchItem(searchTerm : String, completion: @escaping ([PhotoObjects])-> Void){
        
        //URL
        //?key=13326153-5cad3d528ceb1240a0faf91f6&q
        
        let key = "13326153-5cad3d528ceb1240a0faf91f6"
        guard let baseURL = URL(string: "https://pixabay.com/api/") else {completion([]) ; return}
        
        let keyQueryItem = URLQueryItem(name: "key", value: key)
        let searchQueryItem = URLQueryItem(name: "q", value: searchTerm)
        let imageTypeQueryItem = URLQueryItem(name: "image_type", value: "photo")
        
        //create Url components
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        //add query items to the url Components
        urlComponents?.queryItems = [keyQueryItem, searchQueryItem, imageTypeQueryItem]
        
        //Create a final URL with all of the components
        guard let finalURL = urlComponents?.url else {completion([]); return}
        print(finalURL)
        
        //So this is the URL session
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            //So this is to handle the errors
            //guard let error = error else {completion([]); return }
            if let error = error {
                print("Therewas a nissue ")
            }
            guard let data = data else {completion([]); return}
            
            //DECODE
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(topLevelDictionary.hits)
                
            } catch {
                print("Something went wrong?\(error.localizedDescription) \(#function)")
            }
        }.resume()
    }
    
    //Now we are creating the Image
    static func fetchImage(item: PhotoObjects, completion: @escaping (UIImage?) -> Void) {
        
        //get the url
        guard let imageURL = URL(string: item.image) else {completion(nil); return}
        print(imageURL)
        
        //url session
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            
            //Do the errors
            if let error = error {
                print("Therewas a nissue ")

            }
            
            //verify if we got the data
            guard let data = data else {completion(nil); return}
            
            //init and complete
            let imageUrl = UIImage(data: data)
            completion(imageUrl)
        }.resume()
    }
}
