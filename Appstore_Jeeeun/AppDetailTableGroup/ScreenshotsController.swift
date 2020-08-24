//
//  ScreenshotsController.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/22.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit


class ScreenshotsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
    let cellId = "cellId"
    
    var detailInfo: Result? {
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
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailInfo?.screenshotUrls!.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotCell
        let screenshotUrl = self.detailInfo?.screenshotUrls![indexPath.item]
        if let url = URL(string: screenshotUrl ?? "")  {
            cell.imageView.downloaded(from:url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
    
}
class ScreenshotCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //  imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .clear
        addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleToFill
        imageView.stylingImv()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
