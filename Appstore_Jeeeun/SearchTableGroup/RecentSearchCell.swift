//
//  RecentSearchCell.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/20.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//


import UIKit
class RecentSearchCell : UITableViewCell {
   
    static let identifier = "recentSearchCell"
    let wordTableViewController = WordTableViewController()
    
    
    fileprivate let recentSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //여긴 아님.. //programacally 만들엇을경우
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(recentSearchLabel)
        addSubview(wordTableViewController.view)
        recentSearchLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 5, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        wordTableViewController.view.anchor(top: recentSearchLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 5, right: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
