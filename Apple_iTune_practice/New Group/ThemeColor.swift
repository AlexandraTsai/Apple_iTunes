//
//  ThemeColor.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/23.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

enum ThemeColor {
    
    case dark
    case bright
    
}

class ALColor {
    
    static var theme = ThemeColor.bright {
        
        didSet {
            
            switch theme {
            case .bright:
                
                ALColor.c1 = ALColor.white
                ALColor.c2 = ALColor.darkGreen
                
            default:
                
                ALColor.c1 = ALColor.white
                ALColor.c2 = ALColor.darkGreen
            }
        }
    }
    
    static var c1 = darkGreen
    
    static var c2 = white
    
    private static let darkGreen = UIColor(red: 100/255, green: 122/255, blue: 106/255, alpha: 1)
    
    private static let white = UIColor.white

}
