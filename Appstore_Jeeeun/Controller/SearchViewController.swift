//
//  SearchViewController.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/20.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate  {
    
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let cellId = "searchView"
    private var searchListVM: SearchListViewModel!
    var timer: Timer?
    
    
    override func viewDidLoad() {
        self.navigationItem.title = "검색"
        setupSearchBar()
        searchListVM = SearchListViewModel(delegate: self)
      
        tableView.separatorStyle = .none
        tableView.register(RecentSearchCell.self, forCellReuseIdentifier: RecentSearchCell.identifier)
        tableView.reloadData()
        tableView.register(RecommendedWordCell.self, forCellReuseIdentifier: RecommendedWordCell.identifier)
        
    }
    
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        searchListVM.showRecentWord = true
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchListVM.showRecentWord = false
        searchListVM.showResultPage = false
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        searchListVM.showRecentWord = true
        
        searchListVM.searchText  = searchText
        //    print("\(searchListVM.sortedSearchList)")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "")
        guard let searchText = searchBar.text  else { return }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.searchListVM.fetchAppList(searchText)
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchListVM.showResultPage{
            let result = searchListVM.didSelect(at: indexPath)
            let appId = String(result.trackId)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let selectedAppController = storyboard.instantiateViewController(withIdentifier: "selectedAppController") as! SelectedAppController
            selectedAppController.appId = appId
            self.navigationController?.pushViewController(selectedAppController, animated: true)
            
            
        }else if searchListVM.showRecentWord  {
            searchListVM.searchTextWithTableViewCell(at: indexPath)
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchListVM.showRecentWord {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedWordCell.identifier, for: indexPath) as! RecommendedWordCell
            cell.selectionStyle = .none
            cell.recommendTextLabel.text = searchListVM.sortedSearchList[indexPath.row]
            return cell
            
        }else if searchListVM.showResultPage{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell
            cell.appResult = searchListVM.searchResults[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchCell.identifier, for: indexPath) as! RecentSearchCell
            cell.isUserInteractionEnabled = false
            cell.wordTableViewController.searchList = searchListVM.searchList
            cell.wordTableViewController.didSelectHandler = { [weak self] str in
                self?.searchListVM.showRecentWord = false
                self?.searchListVM.showResultPage = false
                self?.searchListVM.fetchAppList(str)
            }
            cell.wordTableViewController.tableView.reloadData()
            return cell
            
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchListVM.showRecentWord {
            return searchListVM.sortedSearchList.count
        }else if searchListVM.showResultPage{
            return searchListVM.searchResults.count
        }
        else{
            return 1
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchListVM.showRecentWord {
            return 44
        }else if searchListVM.showResultPage{
            return 330
        }else{
            
            return CGFloat(searchListVM.searchList.count * 44 + 90)
        }
        
    }
    
}
extension SearchViewController:SearchViewModelProtocol {
    func onFetchFailed(with reason: String) {
        print("\(reason)")
    }
    
    
    func onFetchCompleted() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
