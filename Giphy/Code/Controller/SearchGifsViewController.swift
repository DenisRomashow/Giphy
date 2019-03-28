//
//  ViewController.swift
//  Giphy
//
//  Created by Denis Romashov on 3/28/19.
//  Copyright © 2019 Denis Romashov. All rights reserved.
//

import UIKit

class SearchGifsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var gifs = [Giphy]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension SearchGifsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiphyCollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 50
        return gifs.count
    }
}

extension SearchGifsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Communicator.gifs(search: searchText)
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
