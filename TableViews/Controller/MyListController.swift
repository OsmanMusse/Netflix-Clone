//
//  MyListController.swift
//  TableViews
//
//  Created by Mezut on 19/09/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit


protocol SettingScreenDelegate {
    func goToHome()
}

class MyListController: UIViewController {
    
    
    var delegate: SettingScreenDelegate?
    var settingScreen: SettingScreenController?
    
    let blackTopView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    let messageLabel: UILabel = {
        let message = UILabel()
        message.text = "Add films & TV programmes to your list so you can easily find them later."
        message.textColor = .white
        message.textAlignment = .center
        message.numberOfLines = 3
        message.lineBreakMode = .byWordWrapping
        message.translatesAutoresizingMaskIntoConstraints = false
        return message
    }()
    
    
    let addMessageView: UIView = {
        let addIcon = UIImageView(image: #imageLiteral(resourceName: "My-list-add").withRenderingMode(.alwaysOriginal))
        addIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1)
        view.layer.cornerRadius = 75
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addIcon)
        
        addIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    
    lazy var findSomethingBtn: UIButton = {
       let button = UIButton()
        button.setTitle("Find Something To Watch".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(goToHomeController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
       setupNavigationController()
        view.backgroundColor = Colors.settingBg
        setupLayout()
    }
    
    func setupNavigationController(){
        
        self.navigationItem.title = "My List"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]

        let leftArrow  = UIBarButtonItem(image: #imageLiteral(resourceName: "back-btn").withRenderingMode(.alwaysOriginal), style: .plain
            , target: self, action: #selector(handleBackBtn))
       leftArrow.imageInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
         navigationItem.leftBarButtonItems = [leftArrow]
    }
    
    
    @objc func handleBackBtn(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goToHomeController(){
        let homeScreen = self.tabBarController?.viewControllers?[0]
        
     
        self.tabBarController?.selectedIndex = 0
        
    }
    
    func setupLayout() {
        view.addSubview(blackTopView)
        view.addSubview(addMessageView)
        view.addSubview(messageLabel)
        view.addSubview(findSomethingBtn)
        
        
        NSLayoutConstraint.activate([
              blackTopView.topAnchor.constraint(equalTo: self.view.topAnchor),
              blackTopView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
              blackTopView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
              blackTopView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
              blackTopView.heightAnchor.constraint(equalToConstant: 90),
              
              addMessageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              addMessageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
              addMessageView.widthAnchor.constraint(equalToConstant: 150),
              addMessageView.heightAnchor.constraint(equalToConstant: 150),
              
              messageLabel.topAnchor.constraint(equalTo: addMessageView.bottomAnchor, constant: 17),
              messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
              messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
              messageLabel.heightAnchor.constraint(equalToConstant: 80),
              
              findSomethingBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
              findSomethingBtn.widthAnchor.constraint(equalToConstant: 245),
              findSomethingBtn.heightAnchor.constraint(equalToConstant: 40),
              findSomethingBtn.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
    
            ])
    }
    
    

}


extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
