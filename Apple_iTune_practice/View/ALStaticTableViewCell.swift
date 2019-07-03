//
//  ALStaticTableViewCell.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/24.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class ALStaticTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCellBorder()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellBorder() {
       self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }

}
