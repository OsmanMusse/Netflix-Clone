//
//  Extensions.swift
//  NetflixApp
//
//  Created by Mezut on 17/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func setupNavigationbar(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Help", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
    
        
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "netflix (1)"))
        
        // Makes the navigation bar transparent and removes the default grey background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
}

