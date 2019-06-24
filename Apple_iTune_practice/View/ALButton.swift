//
//  ALButton.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/23.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class ALButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupBtn()
    }
    
    func setupBtn() {
        
        self.backgroundColor = ALColor.c1
        self.layer.cornerRadius = 5
    }
}
