//
//  ThemeColorViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/24.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

protocol ThemeColorTableVCDelegate: AnyObject {
    
    func changeThemeColorLabel(to theme: ThemeColor)
}

class ThemeColorTableViewController: UITableViewController {
    
    var selectedCell: Int = 0 {
        
        didSet {
            
            tableView.reloadData()
        }
    }
    
    weak var themeColorDelegate: ThemeColorTableVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
       let cell = tableView.cellForRow(at: NSIndexPath(row: selectedCell, section: 0) as IndexPath)
        
        cell?.accessoryType = .checkmark
        
        self.view.backgroundColor = ALColor.c1
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let numberOfRows = tableView.numberOfRows(inSection: section)
        
        for row in 0..<numberOfRows {
              
            if let cell = tableView.cellForRow(at:NSIndexPath(row: row, section: section) as IndexPath) {
                
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
            
            }
        }
        
        switch indexPath.row {
        case 0:
            themeColorDelegate?.changeThemeColorLabel(to: .dark)
            ALColor.theme = .dark
            
        default:
            themeColorDelegate?.changeThemeColorLabel(to: .bright)
            ALColor.theme = .bright
            
        }
        
        changeThemeColor()
        
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        for cell in tableView.visibleCells {
            
            cell.backgroundColor = ALColor.c6
        }
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.backgroundView?.backgroundColor = ALColor.c1
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        footerView.backgroundColor = ALColor.c1
        
        return footerView
    }
    
    func changeThemeColor() {
        
        //Navigation bar
        let textAttributes = [NSAttributedString.Key.foregroundColor: ALColor.c2,
                              NSAttributedString.Key.font: UIFont(name: "copperplate", size: 25)!]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationController?.navigationBar.barTintColor = ALColor.c1
        self.navigationController?.navigationBar.tintColor = ALColor.c4
        
        //Tab Bar
        self.tabBarController?.tabBar.tintColor = ALColor.c4
        self.tabBarController?.tabBar.barTintColor = ALColor.c1
        
        self.view.backgroundColor = ALColor.c1
        
        tableView.reloadData()

    }
}
