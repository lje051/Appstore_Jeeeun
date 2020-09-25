//
//  ReviewCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/23.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
      static let identifier = "reviewCell"
   
    var digits: [Int] = []
    var offImage = UIImage(named: "emptySrar")
    var halfImage = UIImage(named: "halfFilledSrar")
    var onImage = UIImage(named: "filledSrar")
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    
    @IBOutlet weak var star1Imv: UIImageView!
    @IBOutlet weak var star2Imv: UIImageView!
    @IBOutlet weak var star3Imv: UIImageView!
    @IBOutlet weak var star4Imv: UIImageView!
    @IBOutlet weak var star5Imv: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    func getStarImage(for number: Float, compareNum:Float) -> UIImage? {
           if number > compareNum ||  number == compareNum {
               let image = #imageLiteral(resourceName: "filledStar")
               return image
           } else  if number > compareNum - 1 {
               let image = #imageLiteral(resourceName: "halfFilledStar")
               return image
           } else{
               let image = #imageLiteral(resourceName: "emptyStar")
               return image
           }
       }
       
    func setAppstoreStar(rating:Int) {
        
           let floatValue:Float = Float(rating)
           star1Imv.image = getStarImage(for: floatValue, compareNum: 1.0)
           star2Imv.image = getStarImage(for: floatValue, compareNum: 2.0)
           star3Imv.image = getStarImage(for: floatValue, compareNum: 3.0)
           star4Imv.image = getStarImage(for: floatValue, compareNum: 4.0)
           star5Imv.image = getStarImage(for: floatValue, compareNum: 5.0)
           
        
       }
}
