//
//  ViewController.swift
//  Giphy
//
//  Created by Denis Romashov on 3/28/19.
//  Copyright © 2019 Denis Romashov. All rights reserved.
//

import UIKit
import AVKit

class SearchGifsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var currentPage: Int = 0
    var totalCount: Int = 0
    var gifs = [GiphyData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifier = String(describing: GiphyCollectionViewCell.self)
        collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    private func searchGif(text: String) {
        Communicator.gifs(search: text, completion: { [weak self] (giphy) in
            self?.currentPage = 1
            self?.totalCount = giphy.pagination?.totalCount ?? 0
            self?.gifs = giphy.data
            self?.collectionView.reloadData()
        })
    }
    
    private func loadMoreGifs() {
        currentPage += 1
        Communicator.gifs(search: searchBar.text!, page: currentPage) { (giphy) in
            self.gifs.append(contentsOf: giphy.data)
            self.collectionView.reloadData()
        }
    }
}

extension SearchGifsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: GiphyCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! GiphyCollectionViewCell
        cell.removeVideoPlayer()

        let giphy = gifs[indexPath.item]
        if let mp4Path = giphy.image?.mp4 {
            cell.setupMoviePlayer(url: URL(string: mp4Path))
            cell.startPlayback()
        } else {
            cell.backgroundColor = UIColor.black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if  gifs.count < totalCount && indexPath.item == gifs.count-1 && searchBar.text?.isEmpty == false {
            loadMoreGifs()
        }
    }
}

extension SearchGifsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        searchGif(text: searchText)
    }
}
