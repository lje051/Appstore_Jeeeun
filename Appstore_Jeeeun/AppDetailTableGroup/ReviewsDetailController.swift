//
//  ReviewsDetailController.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/23.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ReviewsDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var reviews: Reviews? {
        didSet {
            collectionView.reloadData()
        }
    }
    init() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            super.init(collectionViewLayout: layout)
            collectionView.decelerationRate = .fast
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.feed.entry.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.identifier, for: indexPath) as! ReviewCell
        
        let entry = self.reviews?.feed.entry[indexPath.item]
//        cell.titleLabel.text = entry?.title.label
//        cell.authorLabel.text = entry?.author.name.label
//        cell.bodyLabel.text = entry?.content.label
        
//        for (index, view) in cell.starsStackView.arrangedSubviews.enumerated() {
//            if let ratingInt = Int(entry!.rating.label) {
//                view.alpha = index >= ratingInt ? 0 : 1
//            }
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
