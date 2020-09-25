//
//  SelectedAppModel.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/09/25.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import Foundation

protocol SelectedAppModelProtocol: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)

}

class SelectedAppModel  {
    var detailInfo: Result?
    var reviews: Reviews?
    var appId:String?
    private weak var delegate: SelectedAppModelProtocol?
    init(delegate: SelectedAppModelProtocol, appId:String) {
        self.delegate = delegate
        self.appId = appId
    }

}

extension SelectedAppModel {

    func numberOfItemsInSection() -> Int{
        if self.reviews != nil {
            return 4
        }else{
            return 3
        }
    }
    
     func fetchData() {
        guard let appId = appId else { return }
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)&country=KR&lang=ko_kr"
        FetchData.shared.fetchJSONData(urlString: urlString) { (result: SearchResult?, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                return
            }
            
            let detailInfo = result?.results.first
            self.detailInfo = detailInfo
            self.delegate?.onFetchCompleted()
        }
        
        let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?lang=ko_kr&cc=kr"
        FetchData.shared.fetchJSONData(urlString: reviewsUrl) { (result: Reviews?, err) in
            
            if let err = err {
                print("Failed to decode reviews:", err)
                return
            }
            
            self.reviews = result
            
            self.delegate?.onFetchCompleted()
            
        }
    }
    
    
  

}

