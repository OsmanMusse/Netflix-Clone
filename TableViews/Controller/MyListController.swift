//
//  MyListController.swift
//  TableViews
//
//  Created by Mezut on 19/09/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit


class MyListController: UIViewController {
    
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
    
    override func viewDidLoad() {
       setupNavigationController()
        view.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1)
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
    func setupLayout() {
        view.addSubview(blackTopView)
        view.addSubview(addMessageView)
        view.addSubview(messageLabel)
        
        
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
              messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
              messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
              messageLabel.heightAnchor.constraint(equalToConstant: 130)
    
            ])
    }
    
    

}


extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
