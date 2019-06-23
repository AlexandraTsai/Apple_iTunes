//
//  ALPageViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/22.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

protocol ALPageViewControllerDelegate: AnyObject {
    
    func turnSegmentController(to index: Int)
}

class ALPageViewController: UIPageViewController {
    
    weak var pageDelegate: ALPageViewControllerDelegate?
    
    lazy var controllers: [UIViewController] = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var controllers = [UIViewController]()
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: String(describing: SavedMovieViewController.self))
        
        controllers.append(detailVC)
        
        let detailVC2 = storyboard.instantiateViewController(withIdentifier: String(describing: SavedMovieViewController.self))
        
        controllers.append(detailVC2)
        
        return controllers
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        dataSource = self
        
        self.turnToPage(index: 0)
    }
    
    func turnToPage(index: Int) {
        
        let controller = controllers[index]
        var direction = UIPageViewController.NavigationDirection.forward
        
        if let currentVC = viewControllers?.first {
            guard let currentIndex = controllers.index(of: currentVC) else { return }
            
            if currentIndex > index {
                direction = .reverse
            }
        }
        
        self.configureDisplaying(viewController: controller)
        
        setViewControllers([controller],
                           direction: direction,
                           animated: true,
                           completion: nil)
        
    }
    
    func configureDisplaying(viewController: UIViewController) {
        
        for (index, vc) in controllers.enumerated() {
            
            if viewController === vc {
                if let detailVC = viewController as? SavedMovieViewController {
                    
                    switch index {
                    case 0:
                        detailVC.mode = ContentMode.movies
                        pageDelegate?.turnSegmentController(to: index)
                        
                    default:
                        
                        detailVC.mode = ContentMode.musics
                        pageDelegate?.turnSegmentController(to: index)

                    }
                    
//                    self.pageDelegate?.turnPageController(to: index)
                }
            }
            
        }
        
    }
}

extension ALPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = controllers.index(of : viewController) {
            
            if index > 0 {
                return controllers[index - 1]
            }
        }
        
        return controllers.last
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = controllers.index(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            }
        }
        
        return controllers.first
        
    }
    
}

extension ALPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        guard let savedDetailVC = pendingViewControllers.first as? SavedMovieViewController else { return }
        self.configureDisplaying(viewController: savedDetailVC)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let previousVC = previousViewControllers.first as? SavedMovieViewController else { return }
        
        if !completed {
            self.configureDisplaying(viewController: previousVC)
        }
    }
    
}
