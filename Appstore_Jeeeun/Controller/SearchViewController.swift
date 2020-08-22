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
    
    //
    fileprivate var searchResults = [Result]()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let cellId = "searchView"
    var sortedSearchList : [String] = []
    var searchList : [String] = []
    var timer: Timer?
    
    var showRecentWord = false {
        didSet{
            if showRecentWord {
                showResultPage = false
            }
        }
    }
    var showResultPage = false {
        didSet{
            if showResultPage {
                showRecentWord = false
            }
        }
    }
    override func viewDidLoad() {
        self.navigationItem.title = "검색"
        setupSearchBar()
        
        
        if Defaults[\.searchList].count > 0 {
            searchList = Defaults[\.searchList]
        }
        
        
        tableView.separatorStyle = .none
        tableView.register(RecentSearchCell.self, forCellReuseIdentifier: RecentSearchCell.identifier)
        tableView.reloadData()
        
        tableView.register(RecommendedWordCell.self, forCellReuseIdentifier: RecommendedWordCell.identifier)
        
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
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // self.tableView.isHidden = true
        
        showRecentWord = true
        
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showRecentWord = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        sortedSearchList = searchList.filter({$0.lowercased().contains(searchText.lowercased())})
        print("\(sortedSearchList)")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "")
        guard let searchText = searchBar.text  else { return }
        let itemExists = searchList.contains(where: {
            $0.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        if !itemExists {
            Defaults[\.searchList].append(searchText)
        }
        
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
                
                self.showResultPage = true
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                //                         self.collectionView.reloadData()
                //                     }
            }
            
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if showResultPage{
            let appId = String(searchResults[indexPath.row].trackId)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let selectedAppController = storyboard.instantiateViewController(withIdentifier: "selectedAppController") as! SelectedAppController
            
            selectedAppController.appId = appId
            self.navigationController?.pushViewController(selectedAppController, animated: true)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showRecentWord {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedWordCell.identifier, for: indexPath) as! RecommendedWordCell
            cell.recommendTextLabel.text = self.sortedSearchList[indexPath.row]
            
            return cell
        }else if showResultPage{
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell
            cell.appResult = searchResults[indexPath.row]
            return cell
        }
        else{
            // if indexPath.row == TableCell.wordCell.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchCell.identifier, for: indexPath) as! RecentSearchCell
            
            cell.wordTableViewController.searchList = Defaults[\.searchList]
            cell.wordTableViewController.tableView.reloadData()
            // set the text from the data model
            
            return cell
            //    }
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showRecentWord {
            return self.sortedSearchList.count
        }else if showResultPage{
            return self.searchResults.count
        }
        else{
            return 1
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if showRecentWord {
            return 44
        }else if showResultPage{
            return 330
        }else{
            //  if indexPath.row == TableCell.wordCell.rawValue {
            return CGFloat(Defaults[\.searchList].count * 44 + 90)
            //  }
        }
        
    }
    
}
