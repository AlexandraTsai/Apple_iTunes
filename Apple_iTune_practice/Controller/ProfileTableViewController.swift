//
//  ProfileTableViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/21.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var savedItemLabel: UILabel!
    @IBOutlet weak var themeColorLabel: UILabel!
    
    var dataCount = 0 {
        
        didSet {
            
            savedItemLabel.text = "共有 \(dataCount) 項收藏"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(savedItemChanged),
                                               name: .savedItemChanged,
                                               object: nil)
        
        fetchData()
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
    
}
