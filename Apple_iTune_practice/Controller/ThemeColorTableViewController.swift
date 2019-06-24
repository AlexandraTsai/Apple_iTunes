//
//  ThemeColorViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/24.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class ThemeColorTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let numberOfRows = tableView.numberOfRows(inSection: section)
        
        for row in 0..<numberOfRows {
              
            if let cell = tableView.cellForRow(at:NSIndexPath(row: row, section: section) as IndexPath) {
                
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
            
            }
        }
        
    }
}
