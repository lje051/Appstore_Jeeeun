//
//  SearchViewModel.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/09/25.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

protocol SearchViewModelProtocol: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)

}

class SearchListViewModel  {
   
    var sortedSearchList : [String] {
        
      return  self.searchList.filter({$0.lowercased().contains(searchText.lowercased())})

    }
    var searchList : [String]  {
        
        if Defaults[\.searchList].count > 0 {
            return  Defaults[\.searchList]
        }else{
            return []
        }
    }
    var searchText = ""
    //최근검색어
    var showRecentWord = false {
        didSet{
            if showRecentWord {
                showResultPage = false
            }
        }
    }
    
    //검색결과페이지
    var showResultPage = false {
        didSet{
            if showResultPage {
                showRecentWord = false
            }
        }
    }
    
    private weak var delegate: SearchViewModelProtocol?
    var searchResults = [Result]()
    
    init(delegate: SearchViewModelProtocol) {
        self.delegate = delegate
    }

}

extension SearchListViewModel {

    
    func fetchAppList(_ searchText:String){
        let itemExists = self.searchList.contains(where: {
            $0.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        if !itemExists {
            Defaults[\.searchList].append(searchText)
          //  self.searchList = Defaults[\.searchList]
        }
        
        print( "\(Defaults[\.searchList]) listlist")
  
    
            
            FetchData.shared.fetchApps(searchTerm: searchText) { (res, err) in
                if let err = err {
                    print("Failed to fetch apps:", err)
                    return
                }
                
                self.searchResults = res?.results ?? []
                print("\(self.searchResults)")
                
                self.showResultPage = true
                self.delegate?.onFetchCompleted()

            }
            
     
    }
 
    
    func didSelect(at indexPath: IndexPath) -> Result {
       
      //  guard let result = self.searchResults[indexPath] else { return }
        return self.searchResults[indexPath.row]
      }
    
    func searchTextWithTableViewCell(at indexPath:IndexPath){
        if self.showRecentWord {
        let searchText = self.sortedSearchList[indexPath.row]
            self.showRecentWord = false
            self.showResultPage = false
         self.fetchAppList(searchText)
           
        }
    }

}

