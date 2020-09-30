//
//  ReviewsDetailController.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/23.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit


class ReviewsDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "ReviewsDetailController"

    
    var reviews: Reviews? {
        didSet {
            collectionView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.feed.entry.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.identifier, for: indexPath) as! ReviewCell
        cell.layer.cornerRadius = 16
        let entry = self.reviews?.feed.entry[indexPath.item]
        cell.titleLabel.text = entry?.title.label
        cell.writerLabel.text = entry?.author.name.label
        cell.contentLabel.text = entry?.content.label
        if let rating = Int(entry!.rating.label) {
              cell.setAppstoreStar(rating:rating)
        }
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
       return  CGSize(width: screenWidth - 50, height:200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
