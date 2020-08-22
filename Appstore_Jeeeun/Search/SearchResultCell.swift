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
              
              let url = URL(string: appResult.artworkUrl100)
             // appIconImv.sd_setImage(with: url)
              
//            //  screenshot1Imv.sd_setImage(with: URL(string: appResult.screenshotUrls![0]))
//              if appResult.screenshotUrls!.count > 1 {
//                  screenshot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls![1]))
//              }
//              
//              if appResult.screenshotUrls!.count > 2 {
//                  screenshot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls![2]))
//              }
          }
      }
    
  
   

}
