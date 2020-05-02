//
//  CustomTabBarController.swift
//  TableViews
//
//  Created by Mezut on 27/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
 

    override func viewDidLoad() {
   
    
    
        self.navigationController?.hidesBarsOnSwipe = true
        
        
        self.delegate = self
        // setup the tab bar
        
        tabBar.tintColor = .white
        self.tabBarController?.tabBar.isTranslucent = false
        
        
        
        let layout = UICollectionViewFlowLayout()
        let appScreenController = HomeScreen(collectionViewLayout: layout)
        appScreenController.navigationItem.hidesBackButton = true
        
        
        appScreenController.tabBarItem.image = #imageLiteral(resourceName: "home")
        appScreenController.tabBarItem.title = "Home"
        
        
        let searchLayout = UICollectionViewFlowLayout()
        let searchController = SearchController(collectionViewLayout: searchLayout)
        searchController.tabBarItem.image = #imageLiteral(resourceName: "magnifying-glass (1)")
        searchController.tabBarItem.title = "Search"
        
        
        let downloaderController = DownloadScreen()
        downloaderController.tabBarItem.image = #imageLiteral(resourceName: "download")
        downloaderController.tabBarItem.title = "Downloads"
        
        let downloaderNavigationController = UINavigationController(rootViewController: downloaderController)
        
        
        let moreController = SettingScreenController()
        moreController.tabBarItem.image = #imageLiteral(resourceName: "menu (2)")
        moreController.tabBarItem.title = "More"
        
        let moreNavigationController = UINavigationController(rootViewController: moreController)
        moreNavigationController.modalPresentationStyle = .fullScreen
        
        let mainNavigationController = UINavigationController(rootViewController: appScreenController)
        mainNavigationController.navigationItem.hidesBackButton = true
    
        
        viewControllers  = [mainNavigationController, searchController, downloaderNavigationController, moreNavigationController]
        
        
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarAnimatedTransitioning()
    }
    
  





public class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    /*
     Tells your animator object to perform the transition animations.
     */
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        destination.alpha = 0.0
        destination.transform = CGAffineTransform(translationX: 50, y: 0)
        transitionContext.containerView.addSubview(destination)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destination.alpha = 1.0
            destination.transform = CGAffineTransform(translationX: 50, y: 0)
            destination.transform = .identity
        }, completion: { transitionContext.completeTransition($0) })
    }
    
    /*
     Asks your animator object for the duration (in seconds) of the transition animation.
     */
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
}
    
    
}
    
}

