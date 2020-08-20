//
//  SearchViewController.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/20.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//
import SwiftyUserDefaults
import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource  {
    
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
    var searchList : [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var timer: Timer?
    let tableView = UITableView(frame: .zero, style: .plain)
    fileprivate let recentSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    override func viewDidLoad() {
        self.navigationItem.title = "검색"
        setupSearchBar()
        view.addSubview(recentSearchLabel)
        view.addSubview(tableView)
        // view.addSubview(tableView)
        recentSearchLabel.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 160, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 90))
        tableView.anchor(top: recentSearchLabel.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 10, right: 16))
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(WordCell.self, forCellReuseIdentifier: WordCell.identifier)
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchList = Defaults[\.searchList]
        
    }
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // enterSearchTermLabel.isHidden = appResults.count != 0
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchViewCell
        //          cell.appResult = appResults[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.identifier, for: indexPath) as! WordCell
        
        // set the text from the data model
        cell.wordTextLabel.text = self.searchList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.searchList.count
    }
}
