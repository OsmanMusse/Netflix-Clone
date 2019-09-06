//
//  CustomTabBarController.swift
//  TableViews
//
//  Created by Mezut on 27/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.navigationController?.hidesBarsOnSwipe = true
        
        // setup the tab bar
        
        tabBar.tintColor = .white
        
        
        let appScreenController = HomeScreen()
        
        appScreenController.tabBarItem.image = #imageLiteral(resourceName: "home")
        appScreenController.tabBarItem.title = "Home"
        
        let searchController = UIViewController()
        
        searchController.tabBarItem.image = #imageLiteral(resourceName: "magnifying-glass (1)")
        searchController.tabBarItem.title = "Search"
        
        let downloaderController = UIViewController()
        downloaderController.tabBarItem.image = #imageLiteral(resourceName: "download")
        downloaderController.tabBarItem.title = "Downloads"
        
        let moreController = UIViewController()
        moreController.tabBarItem.image = #imageLiteral(resourceName: "menu (2)")
        moreController.tabBarItem.title = "More"
        
        
        
        let mainNavigationController = UINavigationController(rootViewController: appScreenController)
        
        
        
        viewControllers  = [mainNavigationController, searchController, downloaderController, moreController]
        
        
        
    }
    
}
