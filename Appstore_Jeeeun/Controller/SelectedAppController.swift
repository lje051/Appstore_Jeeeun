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
  
    var appId:String!
    var isReady = false
    private var selectedAppModel: SelectedAppModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.largeTitleDisplayMode = .never
        self.title = ""
        selectedAppModel = SelectedAppModel(delegate: self, appId:appId)
        selectedAppModel.fetchData()
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selectedAppModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            //profilecell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailInfoCell.identifier, for: indexPath) as! DetailInfoCell
            if selectedAppModel.detailInfo != nil{
                cell.detailInfo = selectedAppModel.detailInfo
            }
            
            cell.openAppBtn.layer.cornerRadius = 16
            return cell
        }
        else  if indexPath.item == 1 {
            //horizontalController
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:PreScreenshotMainCell.identifier, for: indexPath) as! PreScreenshotMainCell
            cell.horizontalController.detailInfo = selectedAppModel.detailInfo
            
            return cell
        }else  if indexPath.item == 2 {
            //horizontalController
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutCell.identifier, for: indexPath) as! AboutCell
            cell.detailInfo = selectedAppModel.detailInfo
            return cell
        }
        else {
            //  평가및 리뷰
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewListCell.identifier, for: indexPath) as! ReviewListCell
            cell.reviewsController.reviews = selectedAppModel.reviews
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 600
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        if indexPath.item == 0 {
             if selectedAppModel.detailInfo != nil{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailInfoCell.identifier, for: indexPath) as! DetailInfoCell
                cell.whatsNewLabel.text = selectedAppModel.detailInfo?.releaseNotes
                 cell.whatsNewLabel.sizeToFit()
                 height = cell.whatsNewLabel.frame.height  + 200
            }
           
        }else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutCell.identifier, for: indexPath) as! AboutCell
            if selectedAppModel.detailInfo != nil{
                cell.aboutAppLabel.text =  selectedAppModel.detailInfo?.description
                cell.aboutAppLabel.sizeToFit()
                height = cell.aboutAppLabel.frame.height + 40
            }
            
        }else if indexPath.item == 3 {
            height = 280
        }
        
        return  CGSize(width: screenWidth - 30, height:height)
        
    }
    
    
}
extension SelectedAppController : SelectedAppModelProtocol{
    func onFetchCompleted() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func onFetchFailed(with reason: String) {
        print("\(reason)")
    }
  
    
}
