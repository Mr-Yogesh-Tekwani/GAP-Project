//
//  JournalViewController.swift
//  GAP International
//
//  Created by Yogesh on 6/21/23.
//

import UIKit

class JournalViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
    }

}
