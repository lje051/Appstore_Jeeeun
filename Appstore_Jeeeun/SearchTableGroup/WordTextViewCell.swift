//
//  WordTextViewCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/21.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class WordTextViewCell: UITableViewCell {
    static let identifier = "wordTextViewCell"
    
    let wordTextLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = #colorLiteral(red: 0.05490196078, green: 0.4784313725, blue: 0.9960784314, alpha: 1)
     lbl.font = UIFont.systemFont(ofSize: 16)
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
        addSubview(wordTextLabel)
        wordTextLabel.anchor(top:self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top:3, left: 10, bottom: 3, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
