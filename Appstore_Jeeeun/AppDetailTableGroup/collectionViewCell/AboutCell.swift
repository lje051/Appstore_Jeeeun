//
//  AboutCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/24.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class AboutCell: UICollectionViewCell {
    @IBOutlet weak var aboutAppLabel: UILabel!
    var detailInfo: Result! {
           didSet {
               guard let detailInfo = detailInfo else { return }
               aboutAppLabel.text = detailInfo.description
              // descLabel.text = detailInfo.artistName
           }
       }
       
}
