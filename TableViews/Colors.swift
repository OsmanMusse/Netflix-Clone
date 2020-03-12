//
//  Colors.swift
//  TableViews
//
//  Created by Mezut on 13/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class Colors {
    static var mainblackColor: UIColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
    static var lightGray: UIColor = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)
    static var btnGray: UIColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
    static var darkGray: UIColor =  UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
    static var btnLightGray: UIColor = UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1)
    static var collectionViewGray: UIColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1)
    static var settingBg: UIColor =  UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1)
    static var switchColor: UIColor = UIColor(red: 54/255, green: 122/255, blue: 253/100, alpha: 1)
    static var underLineBackgroundColor: UIColor = UIColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1)
    
    static var usedBarBackgroundColor: UIColor = UIColor(red: 73/255, green: 73/255, blue: 73/255, alpha: 1)
    
    static var mainRed: UIColor  = UIColor(red: 229/255, green: 31/255, blue: 19/255, alpha: 1)
    static var darkDarkGray: UIColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1)
}


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

