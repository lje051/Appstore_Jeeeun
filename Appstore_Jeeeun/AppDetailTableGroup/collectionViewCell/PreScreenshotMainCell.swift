//
//  PreScreenshotMainCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/22.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class PreScreenshotMainCell: UICollectionViewCell {
    @IBOutlet weak var previewLabel: UILabel!
    let horizontalController = ScreenshotsController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(horizontalController.view)
        horizontalController.view.backgroundColor = .yellow
        horizontalController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 10, right: 0))
    }
    
}
