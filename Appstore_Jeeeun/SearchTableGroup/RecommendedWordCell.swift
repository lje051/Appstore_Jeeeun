//
//  RecommendedWordCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/22.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class RecommendedWordCell: UITableViewCell {

     static let identifier = "recommendedWordCell"
         private let searchIcon : UIImageView = {
               let imgView = UIImageView(image:#imageLiteral(resourceName: "searchIcon"))
            imgView.contentMode = .scaleAspectFit
            imgView.clipsToBounds = true
            return imgView
            }()
           
        let recommendTextLabel : UILabel = {
         let lbl = UILabel()
         lbl.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
         lbl.font = UIFont.systemFont(ofSize: 18)
         lbl.textAlignment = .left
         lbl.numberOfLines = 0
         return lbl
         }()
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
             addSubview(searchIcon)
            addSubview(recommendTextLabel)
            searchIcon.anchor(top:nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top:0, left: 10, bottom: 10, right: 10), size:.init(width:20, height:20) )
            recommendTextLabel.anchor(top:nil, leading: searchIcon.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top:3, left: 10, bottom:10, right: 10))
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
