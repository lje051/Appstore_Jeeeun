//
//  ScreenshotCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/22.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class PrescreenshotMainCell: UICollectionViewCell {
    let horizontalController = ScreenshotsController()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           
           
           addSubview(horizontalController.view)
           
          
           
         //  horizontalController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError()
       }
}
