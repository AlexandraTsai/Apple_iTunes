//
//  ProfileTableViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/21.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var currentSavedLabel: UILabel!
    @IBOutlet weak var currentColorLabel: UILabel!
    @IBOutlet weak var themeColorLabel: UILabel!
    @IBOutlet weak var savedLabel: UILabel!
    
    var dataCount = 0 {
        
        didSet {
            
            currentSavedLabel.text = "Saved \(dataCount) items"
        }
    }
    
    var currentThemeColor: ThemeColor = ThemeColor.dark

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(savedItemChanged),
                                               name: .savedItemChanged,
                                               object: nil)
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.backgroundColor = ALColor.c1
        
        currentSavedLabel.textColor = ALColor.c2
        currentColorLabel.textColor = ALColor.c2
        
        savedLabel.textColor = ALColor.c5
        themeColorLabel.textColor = ALColor.c5
        
        setupNavigationBar()
        
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = ALColor.c1
        self.navigationController?.navigationBar.tintColor = ALColor.c4
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: ALColor.c2,
                              NSAttributedString.Key.font: UIFont(name: "copperplate", size: 25)!]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
    }
    
    func fetchData() {
        
        if let savedMovie = UserDefaults.standard.object(forKey: "movie") as? Data {
            
            if let loadedMovie = try? PropertyListDecoder().decode([Movie].self, from: savedMovie) {
                
                dataCount += loadedMovie.count
                
            }
        }
        
        if let savedMusic = UserDefaults.standard.object(forKey: "music") as? Data {
            
            if let loadedMusic = try? PropertyListDecoder().decode([Music].self, from: savedMusic) {
                
                dataCount += loadedMusic.count
                
            }
        }
    }
    
    @objc func savedItemChanged() {
        
        dataCount = 0
        
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showThemeColorSegue" {
            
            if let themeColorVC = segue.destination as? ThemeColorTableViewController {
                
                themeColorVC.themeColorDelegate = self
                
                switch currentThemeColor {
                case .dark:
                    
                    themeColorVC.selectedCell = 0
                    
                default:
                    
                    themeColorVC.selectedCell = 1
                    
                }
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let cells = tableView.visibleCells
        
        for cell in cells {
            cell.backgroundColor = ALColor.c6
            
        }
       
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.backgroundView?.backgroundColor = ALColor.c1
        
    }
    
}

extension ProfileTableViewController: ThemeColorTableVCDelegate {
    
    func changeThemeColorLabel(to theme: ThemeColor) {
        
        switch theme {
        case .dark:
            
            currentColorLabel.text = "Dark"
            currentThemeColor = .dark
            
        default:
            
            currentColorLabel.text = "Bright"
            currentThemeColor = .bright

        }
        
    }
    
    
}
