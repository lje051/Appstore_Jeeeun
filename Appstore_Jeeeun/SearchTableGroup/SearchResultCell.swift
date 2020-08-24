//
//  SearchResultCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/22.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit


class SearchResultCell: UITableViewCell {
    @IBOutlet weak var appIconImv: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var downloadNumLabel: UILabel!
    @IBOutlet weak var openAppBtn: UIButton!
    @IBOutlet weak var screenshot1Imv: UIImageView!
    @IBOutlet weak var screenshot2Imv: UIImageView!
    @IBOutlet weak var screenshot3Imv: UIImageView!
    @IBOutlet weak var star1Imv: UIImageView!
    @IBOutlet weak var star2Imv: UIImageView!
    @IBOutlet weak var star3Imv: UIImageView!
    @IBOutlet weak var star4Imv: UIImageView!
    @IBOutlet weak var star5Imv: UIImageView!
 
    var digits: [Int] = []
    var offImage = UIImage(named: "emptySrar")
    var halfImage = UIImage(named: "halfFilledSrar")
    var onImage = UIImage(named: "filledSrar")
    static let identifier = "searchResultCell"
    
    var appResult: Result! {
        didSet {
            appNameLabel.text = appResult.trackName
            descLabel.text = appResult.primaryGenreName
            setAppstoreStar()
            setScreenshotImv()
            guard let downloadNum = appResult.userRatingCountForCurrentVersion else { return }
            digits.removeAll()
            
            let digitInt = findDigitNum(num: downloadNum)
            print("bigName\(digitInt)")
            if let bigNumberName = bigNumberName(place: digitInt){
                //천단위보다 높은경우 한단계 전 숫자까지 노출, 0은 제외
                let endNum = String(digits [digitInt - 1])
                let secondEndNum = String(digits [digitInt - 2])
                print("\(endNum).\(secondEndNum)\(bigNumberName)")
                if secondEndNum != "0"{
                    downloadNumLabel.text = "\(endNum).\(secondEndNum)\(bigNumberName)"
                }
                //10만 단위는 "."을 표기하지않고 점없이 첫번째, 두번째자리 표시
                if digitInt == 6 {
                    downloadNumLabel.text = "\(endNum)\(secondEndNum)\(bigNumberName)"
                }
            }else{
                //천단위보다 적은경우 금액노출
                downloadNumLabel.text = "\(downloadNum)"
            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appIconImv.layer.cornerRadius = 12
        openAppBtn.layer.cornerRadius = 16
        screenshot1Imv.stylingImv()
        screenshot2Imv.stylingImv()
        screenshot3Imv.stylingImv()
        screenshot3Imv.stylingImv()
        // Initialization code
    }
    
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
    
    func setAppstoreStar() {
        guard  let rating =  appResult.averageUserRating else { return }
        let floatValue:Float = Float(rating)
        star1Imv.image = getStarImage(for: floatValue, compareNum: 1.0)
        star2Imv.image = getStarImage(for: floatValue, compareNum: 2.0)
        star3Imv.image = getStarImage(for: floatValue, compareNum: 3.0)
        star4Imv.image = getStarImage(for: floatValue, compareNum: 4.0)
        star5Imv.image = getStarImage(for: floatValue, compareNum: 5.0)
        
       
    }
    
    func setScreenshotImv() {
        if let url = URL(string: appResult.artworkUrl100) {
                   appIconImv.downloaded(from: url)
               }
               
               if let url1 = URL(string: appResult.screenshotUrls?[0] ?? ""){
                   screenshot1Imv.downloaded(from:url1)
               }
               if appResult.screenshotUrls!.count > 1 {
                   if  let url2 = URL(string: appResult.screenshotUrls?[1] ?? ""){
                       screenshot2Imv.downloaded(from:url2)
                   }
               }
               if appResult.screenshotUrls!.count > 2 {
                   if  let url3 = URL(string: appResult.screenshotUrls?[2] ?? ""){
                       screenshot3Imv.downloaded(from:url3)
                   }
               }
    }
    
    func bigNumberName (place: Int) -> String? {
        switch (place) {
        case 4: return "천"
        case 5, 6: return "만"
        case 7: return "백만"
        case 8: return "천만"
        case 9: return "억"
        default:return nil
        }
    }
    
    func findDigitNum(num:Int) -> Int {
        var targetNum = num
        while targetNum != 0 {
            digits.append(abs(targetNum%10))
            targetNum /= 10
        }
        let totalPlaces = digits.count
        return totalPlaces
    }
}

