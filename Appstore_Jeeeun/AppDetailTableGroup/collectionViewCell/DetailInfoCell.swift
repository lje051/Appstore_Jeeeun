//
//  DetailInfoCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/22.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class DetailInfoCell: UICollectionViewCell {
    @IBOutlet weak var appIconImv: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var openAppBtn: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    //  @IBOutlet weak var whatsNewBtn: UIButton!
    
    @IBOutlet weak var whatsNewLabel: UILabel!
    static let identifier = "detailInfoCell"
    
    var detailInfo: Result! {
        didSet {
            guard let detailInfo = detailInfo else { return }
            appNameLabel.text = detailInfo.trackName
            descLabel.text = detailInfo.artistName
            versionLabel.text = "버전 \(detailInfo.version)"
            guard let releaseNotes = detailInfo.releaseNotes else { return }
            whatsNewLabel.text = releaseNotes
            guard let releaseDate = detailInfo.currentVersionReleaseDate else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")// set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: releaseDate)!
            releaseDateLabel.text = date.timeAgoDisplay()
            if  let artworkUrl100 = URL(string: detailInfo.artworkUrl100){
                appIconImv.stylingImv()
                appIconImv.downloaded(from:artworkUrl100)
            }
            moreBtn.setTitle(detailInfo.formattedPrice, for: .normal)
        }
    }
    
  
   
}
