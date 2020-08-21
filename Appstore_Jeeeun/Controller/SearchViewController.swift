//
//  SearchViewController.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/20.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//
import SwiftyUserDefaults
import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate  {

    enum TableCell: Int {
         case wordCell = 0
         case empty

     }
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        <#code#>
    //    }
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        <#code#>
    //    }
    //
    fileprivate var searchResults = [Result]()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let cellId = "searchView"
  
    var timer: Timer?


    
    override func viewDidLoad() {
        self.navigationItem.title = "검색"
        setupSearchBar()
       
  
   
      
       
        tableView.separatorStyle = .none
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.identifier)
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        
    }
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: view.frame.width, height: 350)
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        // introduce some delay before performing the search
        // throttling the search
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            // this will actually fire my search
            FetchData.shared.fetchApps(searchTerm: searchText) { (res, err) in
                if let err = err {
                    print("Failed to fetch apps:", err)
                    return
                }
                
                self.searchResults = res?.results ?? []
                print("\(self.searchResults)")
                //                     DispatchQueue.main.async {
                //                         self.collectionView.reloadData()
                //                     }
            }
            
        })
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "")
        guard let searchText = searchBar.text  else { return }
        Defaults[\.searchList].append(searchText)
        print( "\(Defaults[\.searchList]) listlist")
        // introduce some delay before performing the search
        // throttling the search
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            // this will actually fire my search
            FetchData.shared.fetchApps(searchTerm: searchText) { (res, err) in
                if let err = err {
                    print("Failed to fetch apps:", err)
                    return
                }
                
                self.searchResults = res?.results ?? []
                print("\(self.searchResults)")
                //                     DispatchQueue.main.async {
                //                         self.collectionView.reloadData()
                //                     }
            }
            
        })
    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // enterSearchTermLabel.isHidden = appResults.count != 0
//        return 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchViewCell
//        //          cell.appResult = appResults[indexPath.item]
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == TableCell.wordCell.rawValue {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.identifier, for: indexPath) as! WordTableViewCell
           
        cell.wordTableViewController.searchList = Defaults[\.searchList]
        cell.wordTableViewController.tableView.reloadData()
        // set the text from the data model
      
        return cell
        }else   {
            
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "blankCell", for: indexPath)
                     
            return cell
     }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return UITableView.automaticDimension
      
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == TableCell.wordCell.rawValue {
            return CGFloat(Defaults[\.searchList].count * 44 + 90)
        }else{
            return 1
        }
    }
        
}
