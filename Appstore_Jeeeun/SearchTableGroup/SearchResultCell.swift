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
    static let identifier = "searchResultCell"
    
    var appResult: Result! {
        didSet {
            appNameLabel.text = appResult.trackName
            descLabel.text = appResult.primaryGenreName
            downloadNumLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
            
            
            
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
    
  
    
}
