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
                
                ALColor.c1 = UIColor.white
                ALColor.c2 = UIColor.black
                ALColor.c3 = UIColor.darkGreen
                
            default:
                
                ALColor.c1 = UIColor.darkGray
                ALColor.c2 = UIColor.white
                ALColor.c3 = UIColor.white
                ALColor.c4 = UIColor.darkRed

            }
        }
    }
    
    static var c1 = UIColor.darkGray
    
    static var c2 = UIColor.white //content text color
    
    static var c3 = UIColor.black
    
    static var c4 = UIColor.darkRed //tabBar tintColor
    
    static var c5 = UIColor.lightGray //subtitleColor
    
    static var c6 = UIColor.mediumGray //static cell
    
 
}

extension UIColor {
    
    static let darkGreen = UIColor(red: 100/255, green: 122/255, blue: 106/255, alpha: 1)
   
    //Gray #353848 #585B6D
    static let darkGray = UIColor(red: 53/255, green: 56/255, blue: 72/255, alpha: 1)
    static let mediumGray = UIColor(red: 88/255, green: 91/255, blue: 109/255, alpha: 1)
    static let lightGray = UIColor(red: 164/255, green: 173/255, blue: 173/255, alpha: 1)
    
    //Red #C1424F
    static let darkRed = UIColor(red: 213/255, green: 66/255, blue: 79/255, alpha: 1)
}
