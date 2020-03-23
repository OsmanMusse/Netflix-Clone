//
//  EditProfileController.swift
//  TableViews
//
//  Created by Mezut on 21/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class EditProfileController: UIViewController {
    
    lazy var profileImage: UIImageView = {
      let image = UIImageView(image: #imageLiteral(resourceName: "netflix-profile-2"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.addSubview(changeProfileBtn)
        
        changeProfileBtn.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 7).isActive = true
        changeProfileBtn.centerXAnchor.constraint(equalTo: image.centerXAnchor).isActive = true
        return image
    }()
    
    lazy var changeProfileBtn: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("CHANGE", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.addTarget(self, action: #selector(handleCancelMode), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var textFieldInput: CustomTextField = {
        let tf = CustomTextField()
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1.2
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.widthAnchor.constraint(equalToConstant: 240).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        return tf
    }()
    
    lazy var editStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [profileImage, textFieldInput])
        profileImage.widthAnchor.constraint(equalToConstant: 110).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 110).isActive = true
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var ratingLabel: UIView = {
        
        let ratingLabel = UILabel()
        ratingLabel.text = "ALL MATURITY RATINGS"
        ratingLabel.textColor = UIColor(white: 255/255, alpha: 0.95)
        
        ratingLabel.font = UIFont(name: "Helvetica-Bold", size: 13)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let ratingView = UIView()
        ratingView.backgroundColor = UIColor(red: 47/255, green: 47/255, blue: 47/255, alpha: 1)
        ratingView.layer.cornerRadius = 3
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        ratingView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        
        ratingView.addSubview(ratingLabel)
        
        ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor).isActive = true
        
        
        return ratingView
    }()
    
    var warningTitle: UITextView = {
       let label = UITextView()
        var labelText = "Show titles of all maturity ratings for this profile"
        let fullString = NSMutableAttributedString(string: labelText, attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)])
        fullString.addAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 15)], range: NSRange(location: 14, length: 22))
        label.attributedText = fullString
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    var accountSettingWarningLabel: UITextView = {
        let label = UITextView()
        label.text = "Visit Account Settings on the web to edit viewing restrictions"
        label.backgroundColor = .clear
        label.textColor = Colors.btnLightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var profileInfoStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [ratingLabel, warningTitle])
        warningTitle.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        warningTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
 

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 15
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
        buttonView.distribution = .fillProportionally
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }()
    
  
    
    var profileScreen: ProfileSelector?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavBar()
        setupLayout()
        
        profileScreen = ProfileSelector()
    }
    
  
    func setupNavBar(){
        navigationController?.navigationBar.isHidden = false
        
        navigationController?.navigationBar.shadowImage =  UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupLayout(){
        view.addSubview(editStackView)
        view.addSubview(profileInfoStackView)
        
        
        NSLayoutConstraint.activate([
            
            editStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            editStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            profileInfoStackView.topAnchor.constraint(equalTo: editStackView.bottomAnchor, constant: 25),
            profileInfoStackView.centerXAnchor.constraint(equalTo: editStackView.centerXAnchor),
            profileInfoStackView.widthAnchor.constraint(equalTo: editStackView.widthAnchor, constant: 40),
            profileInfoStackView.heightAnchor.constraint(equalToConstant: 100),
            
     
            
            
            ])
    }
    
    
    
    
    @objc func handleSavingMode(){
        
    }
    
    @objc func handleCancelMode(){
   
        
    self.dismiss(animated: false, completion: nil)
        
        

 
    }
    
   
    
}
