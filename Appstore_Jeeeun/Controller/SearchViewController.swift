//
//  SearchViewController.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/20.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let cellId = "searchView"
    
    override func viewDidLoad() {
        self.navigationItem.title = "검색"
        //setupSearchBar()
    }
    fileprivate func setupSearchBar() {
          definesPresentationContext = true
          navigationItem.searchController = self.searchController
          navigationItem.hidesSearchBarWhenScrolling = false
          searchController.dimsBackgroundDuringPresentation = false
          searchController.searchBar.delegate = self
      }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return .init(width: view.frame.width, height: 350)
      }
      
      override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         // enterSearchTermLabel.isHidden = appResults.count != 0
          return 0
      }
      
      override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchViewCell
//          cell.appResult = appResults[indexPath.item]
          return cell
      }
}
