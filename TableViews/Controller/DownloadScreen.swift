//
//  ViewController.swift
//  TableViews
//
//  Created by Mezut on 13/01/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class DownloadScreen: UIViewController {
    
    
    var downloadView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 70
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var downloadIcon: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "download").withRenderingMode(.alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = Colors.settingBg
        setupNavigationBar()
        setupLayout()
    }
    
    func setupNavigationBar(){
      navigationItem.leftBarButtonItem = UIBarButtonItem()
      navigationController?.navigationBar.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
      navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
      navigationController?.navigationBar.isTranslucent = false
        
        let infoIcon = UIImageView(image: #imageLiteral(resourceName: "information").withRenderingMode(.alwaysOriginal))
        infoIcon.translatesAutoresizingMaskIntoConstraints = false
        infoIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        infoIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        let smartDownloadBtn = UIButton(type: UIButton.ButtonType.custom)
        smartDownloadBtn.translatesAutoresizingMaskIntoConstraints = false
        smartDownloadBtn.isHighlighted = false
        smartDownloadBtn.widthAnchor.constraint(equalToConstant: 119.5).isActive = true
        smartDownloadBtn.setTitle("Smart Downloads", for: .normal)
        smartDownloadBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 0)
        smartDownloadBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        smartDownloadBtn.setTitleColor(UIColor(red: 166/255, green: 167/255, blue: 167/255, alpha: 1), for: .normal)
        
        let turnOnBtn = UIButton(type: UIButton.ButtonType.custom)
        turnOnBtn.setTitle("ON", for: .normal)
        turnOnBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        turnOnBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 0)
        turnOnBtn.setTitleColor(UIColor(red: 15/255, green: 121/255, blue: 247/255, alpha: 1), for: .normal)
        turnOnBtn.isHighlighted = false

        
        let customStackView = UIStackView(arrangedSubviews: [infoIcon,smartDownloadBtn,turnOnBtn])
        customStackView.distribution = .fill
        
        customStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
      navigationItem.leftBarButtonItem?.customView = customStackView
        
  
    }
    
    
    func setupLayout() {
        view.addSubview(downloadView)
        downloadView.addSubview(downloadIcon)
        
        NSLayoutConstraint.activate([
            downloadView.widthAnchor.constraint(equalToConstant: 140),
            downloadView.heightAnchor.constraint(equalToConstant: 140),
            downloadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            
            downloadIcon.centerXAnchor.constraint(equalTo: downloadView.centerXAnchor),
            downloadIcon.centerYAnchor.constraint(equalTo: downloadView.centerYAnchor),
            downloadIcon.widthAnchor.constraint(equalToConstant: 50),
            downloadIcon.heightAnchor.constraint(equalToConstant: 50)
            
            ])
    }
    
}
