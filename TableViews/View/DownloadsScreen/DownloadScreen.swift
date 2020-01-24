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
    
    var downloadTitle: UILabel = {
       let label = UILabel()
        label.text = "Never be without Netflix"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var downloadDescription: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Download programmes and films so you'll never be without something to watch - even when you're offline"
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    lazy var downloadBtn: UIButton = {
      let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("See What You Can Download", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 25, bottom: 14, right: 25)
        button.addTarget(self, action: #selector(goTodownloadScreen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = Colors.settingBg
        setupNavigationBar()
        setupLayout()
    }
    
    @objc func goTodownloadScreen(){
        let layout = UICollectionViewFlowLayout()
        let secondDownloadScreen = innerDownloadScreen(collectionViewLayout: layout)
        navigationController?.pushViewController(secondDownloadScreen, animated: true)
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
        view.addSubview(downloadTitle)
        view.addSubview(downloadDescription)
        view.addSubview(downloadBtn)
        
        NSLayoutConstraint.activate([
            downloadView.widthAnchor.constraint(equalToConstant: 140),
            downloadView.heightAnchor.constraint(equalToConstant: 140),
            downloadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            
            downloadIcon.centerXAnchor.constraint(equalTo: downloadView.centerXAnchor),
            downloadIcon.centerYAnchor.constraint(equalTo: downloadView.centerYAnchor),
            downloadIcon.widthAnchor.constraint(equalToConstant: 60),
            downloadIcon.heightAnchor.constraint(equalToConstant: 60),
            
            downloadTitle.topAnchor.constraint(equalTo: downloadView.bottomAnchor, constant: 20),
            downloadTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            downloadDescription.topAnchor.constraint(equalTo: downloadTitle.bottomAnchor, constant: 20),
            downloadDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            downloadDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            downloadBtn.topAnchor.constraint(equalTo: downloadDescription.bottomAnchor, constant: 20),
            downloadBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            

            
            
            ])
    }
    
}
