//
//  SavedViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/22.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

protocol SavedViewControllerDelegate: AnyObject {
    
    func changePageWith(index: Int)
}

class SavedViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    weak var segmentDelegate: SavedViewControllerDelegate?
    
    var pageViewController = ALPageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowALPageViewController" {
            if let alPageVC = segue.destination as? ALPageViewController {
                
                pageViewController = alPageVC
                pageViewController.pageDelegate = self
            }
        }
    }
    
    @IBAction func indexChanged(_ sender: AnyObject) {
        
        print(sender)
        
        switch sender.selectedSegmentIndex {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SavedMovieViewController.self))
            pageViewController.setViewControllers([vc!], direction: .reverse, animated: true, completion: nil)
            
        default:
            let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SavedMusicViewController.self))
            pageViewController.setViewControllers([vc!], direction: .forward, animated: true, completion: nil)
        }
    }
 
}

extension SavedViewController: ALPageViewControllerDelegate {
    
    func turnSegmentController(to index: Int) {
        
        if let segmentedControl = segmentedControl {
            
            segmentedControl.selectedSegmentIndex = index
        }
        
    }
    
}
