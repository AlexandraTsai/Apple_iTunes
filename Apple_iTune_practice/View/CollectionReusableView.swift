//
//  CollectionReusableView.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/21.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var headerLabel: UILabel!
    
    let sectionHeaderLabel: UILabel = {
        
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 25))
        label.text = "TEST"
        
        label.font = UIFont(name: "copperplate-bold", size: 25)
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.addSubview(sectionHeaderLabel)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(sectionHeaderLabel)
        
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setup() {
        
        self.backgroundColor = ALColor.c3
    }
   
}
