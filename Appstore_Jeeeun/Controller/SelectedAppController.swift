//
//  SelectedAppController.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/22.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "selectedAppController"

class SelectedAppController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var detailInfo: Result? 
    var reviews: Reviews?
    var appId:String?
    
    var isReady = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.largeTitleDisplayMode = .never
        self.title = ""
        fetchData()
    }
    
    
    
    fileprivate func fetchData() {
        guard let appId = appId else { return }
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)&country=KR&lang=ko_kr"
        FetchData.shared.fetchJSONData(urlString: urlString) { (result: SearchResult?, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                return
            }
            
            let detailInfo = result?.results.first
            self.detailInfo = detailInfo
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?lang=ko_kr&cc=kr"
        FetchData.shared.fetchJSONData(urlString: reviewsUrl) { (result: Reviews?, err) in
            
            if let err = err {
                print("Failed to decode reviews:", err)
                return
            }
            
            self.reviews = result
            print("\(self.reviews)")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.reviews != nil {
             return 4
        }else{
            return 3
        }
       
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            //profilecell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailInfoCell.identifier, for: indexPath) as! DetailInfoCell
            if self.detailInfo != nil{
                cell.detailInfo = detailInfo
            }
            
            cell.openAppBtn.layer.cornerRadius = 16
            return cell
        }
        else  if indexPath.item == 1 {
            //horizontalController
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prescreenshotMainCell", for: indexPath) as! PreScreenshotMainCell
            cell.horizontalController.detailInfo = self.detailInfo
            
            return cell
        }else  if indexPath.item == 2 {
            //horizontalController
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutCell", for: indexPath) as! AboutCell
            cell.detailInfo = detailInfo
            return cell
        }
        else {
            //  평가및 리뷰
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewListCell.identifier, for: indexPath) as! ReviewListCell
            cell.reviewsController.reviews = self.reviews
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        if indexPath.item == 1 {
            height = 600
        }else if indexPath.item == 2 {
            height = 200
        }
        
        return  CGSize(width: screenWidth - 30, height:height)
        
    }
   
    
}
