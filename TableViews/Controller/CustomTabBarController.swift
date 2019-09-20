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
        
        let searchLayout = UICollectionViewFlowLayout()
        let searchController = SearchController(collectionViewLayout: searchLayout)
        searchController.tabBarItem.image = #imageLiteral(resourceName: "magnifying-glass (1)")
        searchController.tabBarItem.title = "Search"
        
        let downloaderController = UIViewController()
        downloaderController.tabBarItem.image = #imageLiteral(resourceName: "download")
        downloaderController.tabBarItem.title = "Downloads"
        
        
        let moreControllerlayout = UICollectionViewFlowLayout()
        let moreController = SettingScreen(collectionViewLayout: moreControllerlayout)
        moreController.tabBarItem.image = #imageLiteral(resourceName: "menu (2)")
        moreController.tabBarItem.title = "More"
        
        let moreNavigationController = UINavigationController(rootViewController: moreController)
        
        moreNavigationController.navigationController?.navigationBar.tintColor = .red
        moreNavigationController.navigationController?.navigationBar.barTintColor = .red
        
        let mainNavigationController = UINavigationController(rootViewController: appScreenController)
    
        
        viewControllers  = [mainNavigationController, searchController, downloaderController, moreNavigationController]
        
        
        
    }
    
}
