//
//  EditProfileController.swift
//  TableViews
//
//  Created by Mezut on 21/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class EditProfileController: UIViewController {
    
    let profileImage: UIImageView = {
      let image = UIImageView(image: #imageLiteral(resourceName: "netflix-profile-2"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var changeProfileBtn: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("CHANGE", for: .normal)
        button.addTarget(self, action: #selector(handleCancelMode), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var editStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [profileImage, changeProfileBtn])
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    lazy var editBtn1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(handleSavingMode), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var doneBtn2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var editStack1: UIStackView = {
        let buttonView = UIStackView(arrangedSubviews: [editBtn1])
        buttonView.axis = .horizontal
        buttonView.alignment = .center
        buttonView.spacing = 50
        buttonView.distribution = .fillEqually
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }()
    
    
    lazy var doneStack2: UIStackView = {
        let buttonView = UIStackView(arrangedSubviews: [doneBtn2])
        buttonView.axis = .horizontal
        buttonView.alignment = .center
        buttonView.spacing = 50
        buttonView.distribution = .fillEqually
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }()
    
    var profileScreen: ProfileSelector?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLayout()
         navigationController?.navigationBar.isHidden = false
        
        profileScreen = ProfileSelector()
    }
    
  
    
    func setupLayout(){
        view.addSubview(editStackView)
        
        
        NSLayoutConstraint.activate([
            
            editStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            editStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            
            
            ])
    }
    
    
    
    
    @objc func handleSavingMode(){
        
    }
    
    @objc func handleCancelMode(){

    self.navigationController?.popToRootViewController(animated: true)

 
    }
    
   
    
}
