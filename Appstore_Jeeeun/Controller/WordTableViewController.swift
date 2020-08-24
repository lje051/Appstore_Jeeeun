//
//  WordTableViewController.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/21.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import UIKit

class WordTableViewController: UITableViewController {
  
   
    var searchList : [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(WordTextViewCell.self, forCellReuseIdentifier: WordTextViewCell.identifier)
       tableView.estimatedRowHeight = 44.0
        tableView.reloadData()
    }

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordTextViewCell.identifier, for: indexPath) as! WordTextViewCell
        cell.wordTextLabel.text = self.searchList[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return self.searchList.count
    }

  

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 44
    }


}
