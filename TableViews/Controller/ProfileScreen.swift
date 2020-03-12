//
//  ProfileScreen.swift
//  NetflixApp
//
//  Created by Mezut on 18/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class ProfileScreen: UIViewController {
    
     var watchLabel: UILabel = {
       let label = UILabel()
        label.text = "Who's Watching?"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstAccount: UIView = {
      let view = UIView()
        let image = UIImageView(image: #imageLiteral(resourceName: "netflix-account-1"))
        let label = UILabel()
        label.text = "Jiho"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        view.addSubview(label)
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -3).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }()
    
    let secondAccount: UIView = {
        let view = UIView()
        let image = UIImageView(image: #imageLiteral(resourceName: "netflix-profile-2"))
        let label = UILabel()
        label.text = "Children"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        view.addSubview(label)
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -3).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }()
    
    
    let addProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Profile"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    lazy var addProfileView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        view.layer.cornerRadius = 32.5
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        let image = UIImageView(image: #imageLiteral(resourceName: "plus"))
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var accountStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [firstAccount, secondAccount])
        stackview.axis = .horizontal
        stackview.spacing = 15
        stackview.distribution = .fillProportionally
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        
        // Tap Gesture for the user accounts
        
        setupTapGesture()
        
        // Setup the navigation
        
        setupNavigationbar()
        setupLayout()
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem?.title = "Edit"
    }
    
    
    func setupTapGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleAccountTap))
        firstAccount.isUserInteractionEnabled = true
        firstAccount.addGestureRecognizer(gesture)
    }
    
    
    func setupLayout(){

        
        view.addSubview(watchLabel)
        view.addSubview(accountStackView)
        view.addSubview(addProfileView)
        view.addSubview(addProfileLabel)
        NSLayoutConstraint.activate([
            
            
            watchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            watchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            accountStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            accountStackView.topAnchor.constraint(equalTo: watchLabel.bottomAnchor, constant: 30),
       
            
            accountStackView.widthAnchor.constraint(equalToConstant: 225),
            accountStackView.heightAnchor.constraint(equalToConstant: 140),
            
            addProfileView.widthAnchor.constraint(equalToConstant: 65),
            addProfileView.heightAnchor.constraint(equalToConstant: 65),
            addProfileView.topAnchor.constraint(equalTo: accountStackView.bottomAnchor, constant: 30),
            addProfileView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addProfileLabel.centerXAnchor.constraint(equalTo: addProfileView.centerXAnchor),
            addProfileLabel.topAnchor.constraint(equalTo: addProfileView.bottomAnchor, constant: 25)
            
            ])
    }
    
    
    
    @objc func handleAccountTap() {
        let navbarCOntroller =  CustomTabBarController()
        present(navbarCOntroller, animated: true, completion: nil)
        
        
    }
    
  
    
}
