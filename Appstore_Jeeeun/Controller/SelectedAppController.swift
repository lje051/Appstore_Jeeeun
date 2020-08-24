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
        
        return 4
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            //profilecell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailInfoCell.identifier, for: indexPath) as! DetailInfoCell
            cell.detailInfo = detailInfo
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
        
        var height: CGFloat = 530
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
                if indexPath.item == 0 {
                    height = view.frame.height
                }
        else if indexPath.item == 1 {
                           height = 550
                       }
        
        
        return .init(width: screenWidth - 15, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    
    
    
    
}
