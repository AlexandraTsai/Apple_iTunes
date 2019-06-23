//
//  SavedView.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/23.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class SavedView: UIView, ALPageViewControllerDelegate {
   
    func setupPageController(numberOfPages: Int) {
        print(numberOfPages)
    }
    
    func turnPageController(to index: Int) {
        print(index)
    }
   
}
