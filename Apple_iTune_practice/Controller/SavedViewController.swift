//
//  SavedViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/22.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {
    
    @IBOutlet weak var contentView: SavedView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowALPageViewController" {
            if let alPageVC = segue.destination as? ALPageViewController {
                
                alPageVC.pageDelegate = contentView
            }
        }
    }
 
}
