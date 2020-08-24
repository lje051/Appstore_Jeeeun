//
//  ReviewListCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/23.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class ReviewListCell: UICollectionViewCell {
 
     static let identifier = "reviewListCell"
    @IBOutlet weak var reviewTitleLabel: UILabel!
        
      
    var reviewsController: ReviewsDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ReviewsDetailController.reuseIdentifier) as! ReviewsDetailController

    
   
    override func awakeFromNib() {
           super.awakeFromNib()
           addSubview(reviewsController.view)
       
           reviewsController.view.backgroundColor = .yellow
           reviewsController.view.anchor(top: reviewTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
       }
       
       


}
