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
        
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
        label.text = "TEST"
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.addSubview(sectionHeaderLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(sectionHeaderLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
}
