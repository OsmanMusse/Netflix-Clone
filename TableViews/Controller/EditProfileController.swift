//
//  EditProfileController.swift
//  TableViews
//
//  Created by Mezut on 21/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase
import Hero
import SVProgressHUD

class EditProfileController: UIViewController{
    
    lazy var profileImage: UIImageView = {
      let image = UIImageView()
        image.layer.cornerRadius = 4.5
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
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
    
   
    lazy var doneBtn: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.addTarget(self, action: #selector(handleDoneBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var returnAccessoryView: UIView = {
        let blueView = UIView()
        blueView.backgroundColor = .lightGray
        blueView.autoresizingMask = .flexibleHeight
        blueView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        blueView.addSubview(doneBtn)
        
        doneBtn.centerYAnchor.constraint(equalTo: blueView.centerYAnchor).isActive = true
        doneBtn.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -10).isActive = true
        
    
        return blueView
    }()
    
    
    lazy var textFieldInput: CustomTextField = {
        let tf = CustomTextField()
        tf.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1.2
        tf.textColor = .white
        tf.autocorrectionType = .no
        tf.inputAccessoryView = returnAccessoryView
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
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
        var labelText = "Show titles of all maturity ratings for this profile."
        let fullString = NSMutableAttributedString(string: labelText, attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)])
        fullString.addAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 15)], range: NSRange(location: 14, length: 22))
        label.attributedText = fullString
        label.isEditable = false
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    

    
    var accountSettingWarningLabel: UITextView = {
        let label = UITextView()
        label.text = "Visit Account Settings on the web to edit viewing restrictions."
        label.textColor = Colors.btnLightGray
        label.textAlignment = .center
        label.isEditable = false
        label.backgroundColor = .clear
        label.font = UIFont(name: "Helvetica", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    
    
    
     lazy var rubbishBin: CustomButton = {
       let button = CustomButton(type: .system)
        button.setTitle("DELETE", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setImage(#imageLiteral(resourceName: "Rubbish").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleRemovingProfile), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var textFieldText: String?
    var holdUserIDRecognizer: String?
    var profileScreen: ProfileSelector?
    var profileImgCenterYAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavBar()
        setupKeyboard()
        setupLayout()
    
        textFieldInput.text = textFieldText
        self.hero.isEnabled = true
        self.profileImage.hero.id = "skyWalker"
        self.profileImage.hero.modifiers = [HeroModifier.arc(intensity: -1)]
        
        profileScreen = ProfileSelector()
    }
    
    
    

    func setupNavBar(){
        navigationItem.title = "Edit Profile"
          navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 18)]
        
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleBackBtn))
        
    
        
        let rightBarItem =  UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSavingMode))
        rightBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 15)], for: .normal)
        rightBarItem.tintColor = .white
        
        
        let leftBarItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleBackBtn))
        leftBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 15)], for: .normal)
        leftBarItem.tintColor = .white
        
        
        
        self.navigationItem.setLeftBarButton(leftBarItem, animated: true)
        self.navigationItem.setRightBarButton(rightBarItem, animated: true)

        
        navigationController?.navigationBar.shadowImage =  UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    
    func setupProfileImage(profilePicture: String){
        
        profileImage.image = profileCachedImages[profilePicture]
        
    }
    
    func setupKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @objc func handleKeyboardShow(){
        guard let profileImgConstraint =  profileImgCenterYAnchor?.constant else {return}
         profileImgCenterYAnchor?.constant = profileImgConstraint - 60
        
        ratingLabel.alpha = 0
        warningTitle.alpha = 0
        accountSettingWarningLabel.alpha = 0
        
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func setupLayout(){
        view.addSubview(profileImage)
        view.addSubview(changeProfileBtn)
        view.addSubview(textFieldInput)
        view.addSubview(ratingLabel)
        view.addSubview(warningTitle)
        view.addSubview(accountSettingWarningLabel)
        view.addSubview(rubbishBin)
        
        profileImgCenterYAnchor =  profileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -130)
        profileImgCenterYAnchor?.isActive = true
        
        
        NSLayoutConstraint.activate([
            
            profileImage.widthAnchor.constraint(equalToConstant: 110),
            profileImage.heightAnchor.constraint(equalToConstant: 110),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            changeProfileBtn.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 7),
            changeProfileBtn.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor),
       
            textFieldInput.widthAnchor.constraint(equalToConstant: 240),
            textFieldInput.heightAnchor.constraint(equalToConstant: 50),
            textFieldInput.topAnchor.constraint(equalTo: changeProfileBtn.bottomAnchor, constant: 20),
            textFieldInput.centerXAnchor.constraint(equalTo: changeProfileBtn.centerXAnchor),
            
            
            
            ratingLabel.topAnchor.constraint(equalTo: textFieldInput.bottomAnchor, constant: 30),
            ratingLabel.centerXAnchor.constraint(equalTo: textFieldInput.centerXAnchor),
            
            warningTitle.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 15),
            warningTitle.centerXAnchor.constraint(equalTo: ratingLabel.centerXAnchor),
            warningTitle.widthAnchor.constraint(equalTo: textFieldInput.widthAnchor, constant: 30),
            warningTitle.heightAnchor.constraint(equalToConstant: 45),
            
            accountSettingWarningLabel.topAnchor.constraint(equalTo: warningTitle.bottomAnchor, constant: 0),
            accountSettingWarningLabel.centerXAnchor.constraint(equalTo: warningTitle.centerXAnchor),
            
            accountSettingWarningLabel.widthAnchor.constraint(equalTo: textFieldInput.widthAnchor, constant: 40),
            accountSettingWarningLabel.heightAnchor.constraint(equalToConstant: 50),
            
            rubbishBin.centerXAnchor.constraint(equalTo: textFieldInput.centerXAnchor),
            rubbishBin.topAnchor.constraint(equalTo: accountSettingWarningLabel.bottomAnchor, constant: 20)
            
     
            
            
            ])
    }
    
    
    @objc func handleTextField(){
        let validTextField = textFieldInput.text?.characters.count ?? 0 > 0
        
        
        if (validTextField) {
            navigationItem.rightBarButtonItem?.tintColor = .white
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.tintColor = Colors.btnLightGray
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func handleSavingMode(){
        
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        guard let userIDRecognizer = self.holdUserIDRecognizer else {return}
        guard let textfieldUserText = self.textFieldInput.text else {return}
        
        // Use this image url untill you create the gallery controller
        let imageURL = "https://firebasestorage.googleapis.com/v0/b/netflix-clone-933db.appspot.com/o/netflix-profile.png?alt=media&token=1b419e09-86b4-40c8-b819-4eb96976dc63"

        guard let updateValues = ["ProfileName": textfieldUserText, "ProfileURL":imageURL] as? [String : Any] else {return}
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setBackgroundLayerColor(Colors.btnLightGray.withAlphaComponent(0.4))
        
             Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(userIDRecognizer).updateChildValues(updateValues)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.40) {
            SVProgressHUD.dismiss()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func handleCancelMode(){
        
    self.dismiss(animated: false, completion: nil)
    
    }
    
    @objc func handleBackBtn(){
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func handleDoneBtn(){
        
        
        textFieldInput.resignFirstResponder()
        guard let profileImgConstraint =  profileImgCenterYAnchor?.constant else {return}
        profileImgCenterYAnchor?.constant = profileImgConstraint + 60
   
        // Remove the opacity from the items after keyboard pops down
        ratingLabel.alpha = 1.0
        warningTitle.alpha = 1.0
        accountSettingWarningLabel.alpha = 1.0
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleRemovingProfile(){
    
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        guard let userIDRecognizer = self.holdUserIDRecognizer else {return}
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setBackgroundLayerColor(Colors.btnLightGray.withAlphaComponent(0.4))
        
        
        Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(userIDRecognizer).removeValue { (err, ref) in
            
            if let err = err {
                print("Error item removed")
            }
           
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.40) {
            SVProgressHUD.dismiss()
               self.dismiss(animated: false, completion: nil)
        }
        
      
 
    }
    
   
    
}

