//
//  SettingsHeader.swift
//  TableViews
//
//  Created by Mezut on 27/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class SettingsHeader: UICollectionViewCell {
    
    
    lazy var firstName: UILabel = {
        let firstName = UILabel()
        firstName.text = "Jiho"
        firstName.textColor = .white
        firstName.font = UIFont.boldSystemFont(ofSize: 14)
        
        firstName.translatesAutoresizingMaskIntoConstraints = false
        
        return firstName
    }()
    
    lazy var secondName: UILabel = {
        let secondName = UILabel()
        secondName.text = "Mobbin"
        secondName.textColor = Colors.darkGray
        secondName.font = UIFont.systemFont(ofSize: 14)
        
        secondName.translatesAutoresizingMaskIntoConstraints = false
        
        return secondName
    }()
    
    lazy var firstAccount: UIView = {
        
        let curentView = UIView()
        curentView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImageView(image: #imageLiteral(resourceName: "netflix-profile-1"))
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        
        
        curentView.addSubview(image)
        curentView.addSubview(firstName)
        
        image.centerXAnchor.constraint(equalTo: curentView.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: curentView.centerYAnchor).isActive = true
        firstName.centerXAnchor.constraint(equalTo: curentView.centerXAnchor).isActive = true
        firstName.bottomAnchor.constraint(equalTo: curentView.bottomAnchor, constant: 30).isActive = true
      
        return curentView
    }()
    
    lazy var secondAccount: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "netflix-profile-1"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        
        image.addSubview(secondName)
        
        secondName.centerXAnchor.constraint(equalTo: image.centerXAnchor).isActive = true
        secondName.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: 30).isActive = true
        
        
        return image
    }()
    
    let addProfileBtn: UIView = {
     let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let profileLabel = UILabel()
        profileLabel.text = "Add Profile"
        profileLabel.textColor = Colors.darkGray
        profileLabel.font = UIFont.systemFont(ofSize: 14)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let btnView = UIView()
        btnView.backgroundColor = UIColor(red: 11/255, green: 11/255, blue: 11/255, alpha: 1)
        btnView.layer.cornerRadius = 35
        btnView.translatesAutoresizingMaskIntoConstraints = false
        
        
        btnView.addSubview(button)
        btnView.addSubview(profileLabel)
        
        button.centerXAnchor.constraint(equalTo: btnView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: btnView.centerYAnchor).isActive = true
        profileLabel.centerXAnchor.constraint(equalTo: btnView.centerXAnchor).isActive = true
        profileLabel.bottomAnchor.constraint(equalTo: btnView.bottomAnchor, constant: 30).isActive = true
        
        return btnView
        
    }()
    
    lazy var settingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstAccount, secondAccount, addProfileBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var manageBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "paint-brush").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Manage Profiles", for: .normal) 
        button.setTitleColor(UIColor(red: 132/255, green: 132/255, blue: 132/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 27)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupLayout()
    }
    
    
    func setupLayout(){
        
        addSubview(settingStackView)
        addSubview(manageBtn)
        
        NSLayoutConstraint.activate([
            addProfileBtn.widthAnchor.constraint(equalToConstant:70),
            addProfileBtn.heightAnchor.constraint(equalToConstant: 70),
            
            settingStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            settingStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            settingStackView.widthAnchor.constraint(equalToConstant: 270),
            settingStackView.heightAnchor.constraint(equalToConstant: 70),
            
            manageBtn.topAnchor.constraint(equalTo: settingStackView.bottomAnchor, constant: 55),
            manageBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            manageBtn.widthAnchor.constraint(equalTo: settingStackView.widthAnchor),
            manageBtn.heightAnchor.constraint(equalToConstant: 30)
            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
