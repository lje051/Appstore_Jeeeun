//
//  WordCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/20.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//


import UIKit
class WordCell : UITableViewCell {
 static let identifier = "wordCell"

 
 

 
let wordTextLabel : UILabel = {
 let lbl = UILabel()
 lbl.textColor = #colorLiteral(red: 0.05490196078, green: 0.4784313725, blue: 0.9960784314, alpha: 1)
 lbl.font = UIFont.systemFont(ofSize: 16)
 lbl.textAlignment = .left
 lbl.numberOfLines = 0
 return lbl
 }()
 
 
// private let productImage : UIImageView = {
//    let imgView = UIImageView(image:#imageLiteral(resourceName: <#T##String#>))
// imgView.contentMode = .scaleAspectFit
// imgView.clipsToBounds = true
// return imgView
// }()
// 
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
 super.init(style: style, reuseIdentifier: reuseIdentifier)
 //addSubview(productImage)
 addSubview(wordTextLabel)

 
 //productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        wordTextLabel.anchor(top:nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 4, right: 10))
 
 }
 
 required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
 }
 
 
}
