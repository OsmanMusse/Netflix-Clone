//
//  CreateProfileController.swift
//  TableViews
//
//  Created by Mezut on 24/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

enum NetworkError: Error {
    case ProfileError
}



class CreateProfileController: UIViewController {
    
    var textFieldCenterYAnchor: NSLayoutConstraint?
    var pushFromSuperView: Bool?
    
    lazy var saveBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.isMultipleTouchEnabled = false
        button.setTitleColor(Colors.btnLightGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
        button.addTarget(self, action: #selector(handleSaveBtn), for: .touchUpInside)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(handleFinishMode), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var editStack2: UIStackView = {
        let buttonView = UIStackView(arrangedSubviews: [saveBtn])
        buttonView.axis = .horizontal
        buttonView.alignment = .center
        buttonView.spacing = 50
        buttonView.distribution = .fillEqually
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }()
    

    lazy var doneStack2: UIStackView = {
        let buttonView = UIStackView(arrangedSubviews: [cancelBtn])
        buttonView.axis = .horizontal
        buttonView.alignment = .center
        buttonView.spacing = 50
        buttonView.distribution = .fillEqually
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "netflix-profile-3"))
        image.layer.cornerRadius = 4.5
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var changeProfileBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CHANGE", for: .normal)
        button.addTarget(self, action: #selector(goToImageSelector), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
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
    
    lazy var childrenBtnLabel: UIButton = {
       let button = UIButton()
        button.setTitle("FOR CHILDREN", for: .normal)
        button.addTarget(self, action: #selector(handleToggleBtn), for: .touchUpInside)
        button.alpha = 0
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var childrenSlider: UISwitch =  {
       let btnSwitch = UISwitch()
        btnSwitch.alpha = 0
        btnSwitch.addTarget(self, action: #selector(handleSlider), for: .touchUpInside)
        btnSwitch.onTintColor = Colors.switchColor
        btnSwitch.translatesAutoresizingMaskIntoConstraints = false
        return btnSwitch
    }()
    
    var profileData = [ProfileModel]()
    var profileImageURL: String?
    var defaultProfileImageURL = "https://firebasestorage.googleapis.com/v0/b/netflix-clone-933db.appspot.com/o/netflix-profile.png?alt=media&token=1b419e09-86b4-40c8-b819-4eb96976dc63"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        // Do any additional setup after loading the view.
        setupNavBar()
        setupLayout()
        helperMethod()

        // holding reference to the Notification center of the app
        let NotificationApp = NotificationCenter.default
        
        NotificationApp.addObserver(self, selector: #selector(handleKeyboardShowing), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationApp.addObserver(self, selector: #selector(handleKeyboardDismiss), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    
    
    
    func setupNavBar(){
        navigationItem.title = "Create Profile"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 18)!]
        
        
        
        let customView = UIBarButtonItem(customView: editStack2)
        
        navigationItem.rightBarButtonItems = [customView]
        
        navigationItem.rightBarButtonItem?.tintColor = Colors.btnLightGray
        
        
        let customView2 = UIBarButtonItem(customView: doneStack2)
        
        navigationItem.leftBarButtonItems  =  [customView2]
        
        // Remove the unneeded transparent backgroundColor for the navigationBar
        navigationController?.navigationBar.shadowImage =  UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupProfileImage(profilePicture: String){
        profileImage.image = profileCachedImages[profilePicture]

    }
    
    func setupLayout(){
         view.addSubview(changeProfileBtn)
        view.addSubview(profileImage)
        view.addSubview(textFieldInput)
        view.addSubview(childrenBtnLabel)
        view.addSubview(childrenSlider)
        
        textFieldCenterYAnchor = textFieldInput.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 90)
        textFieldCenterYAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            
             changeProfileBtn.bottomAnchor.constraint(equalTo: textFieldInput.topAnchor, constant: -15),
             changeProfileBtn.centerXAnchor.constraint(equalTo: textFieldInput.centerXAnchor),
             
             profileImage.widthAnchor.constraint(equalToConstant: 110),
             profileImage.heightAnchor.constraint(equalToConstant: 110),
             profileImage.bottomAnchor.constraint(equalTo: changeProfileBtn.topAnchor, constant: -7),
             profileImage.centerXAnchor.constraint(equalTo: textFieldInput.centerXAnchor),
            
            
              textFieldInput.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
              textFieldInput.widthAnchor.constraint(equalToConstant: 240),
              textFieldInput.heightAnchor.constraint(equalToConstant: 50),
              
              childrenBtnLabel.leadingAnchor.constraint(equalTo: textFieldInput.leadingAnchor, constant: 15),
              childrenBtnLabel.topAnchor.constraint(equalTo: textFieldInput.bottomAnchor, constant: 20),
              
              childrenSlider.topAnchor.constraint(equalTo: textFieldInput.bottomAnchor, constant: 20),
              childrenSlider.leadingAnchor.constraint(equalTo: childrenBtnLabel.trailingAnchor, constant: 15)
            
            ])
    }
    
    
    @objc func handleKeyboardShowing(notification: Notification){
        guard  let userInfo = notification.userInfo else {return}
        
        guard let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        guard let keyboardDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        
        // Animate the textfield alongside the keyboard (alongside apples default animation duration)
        UIView.animate(withDuration: keyboardDuration) {
            self.textFieldCenterYAnchor?.constant = keyboardInfo.height - 390
            self.childrenBtnLabel.alpha = 0
            self.childrenSlider.alpha = 0
            self.view.layoutIfNeeded()
            
        }
   
    }
    
    @objc func handleKeyboardDismiss(notification: Notification){
        guard  let userInfo = notification.userInfo else {return}
        
        guard var keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        guard let keyboardDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        
        // Animate the textfield alongside the keyboard (alongside apples default animation duration)
        UIView.animate(withDuration: keyboardDuration) {
            self.textFieldCenterYAnchor?.constant = 90
            self.childrenBtnLabel.alpha = 1.0
            self.childrenSlider.alpha = 1.0
            self.view.layoutIfNeeded()
            
        }
    }


   

    @objc func handleFinishMode(){
        
        if pushFromSuperView == false {
            let tabBarController = CustomTabBarController()
            tabBarController.selectedIndex = 3
            tabBarController.tabBar.barTintColor = UIColor.black
            self.tabBarController?.navigationController?.navigationBar.isHidden = true
            self.navigationController?.setViewControllers([tabBarController], animated: false)
            tabBarController.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.navigationController?.popToRootViewController(animated: true)
            return
        }
        
        textFieldInput.resignFirstResponder()
       self.dismiss(animated: false, completion: nil)
        
        
      
    }
    
    
    
    @objc func handleDoneBtn(){
        textFieldInput.resignFirstResponder()
    }
    
    @objc func handleTextField(){
        let validCharacterCount = textFieldInput.text?.characters.count ?? 0 > 0
        
        if (validCharacterCount) {
            saveBtn.setTitleColor(UIColor.white, for: .normal)
            saveBtn.isEnabled = true
            
        } else {
            saveBtn.setTitleColor(Colors.btnLightGray, for: .normal)
            saveBtn.isEnabled = false
        }
    }
    
    @objc func handleSlider(myswitch: UISwitch){
        
        if myswitch.isOn == false {
            let attributedMessage = NSAttributedString(string: "This Profile will now allow access to TV programmes and films of all maturity levels.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 17)])
            
            let alertController = UIAlertController(title: nil, message:"", preferredStyle: .alert)
            
            alertController.setValue(attributedMessage, forKey: "attributedMessage")
            
            let alertActions = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(alertActions)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @objc func handleToggleBtn(button: UIButton, event: UIEvent){
        
        if childrenSlider.isSelected == true {
            self.childrenSlider.setOn(false, animated: true)
            handleSlider(myswitch: childrenSlider)
            childrenSlider.isSelected = false
            
            
        } else {
            self.childrenSlider.setOn(true, animated: true)
            handleSlider(myswitch: childrenSlider)
            childrenSlider.isSelected = true
        }
        
    }
    
    
    @objc func goToImageSelector(){
        // Got to the Image Selector Screen to select the image for your profile
        
        showActivityIndicator(color: Colors.settingBg.withAlphaComponent(0.4), maskType: .clear)
        
        let layout = UICollectionViewFlowLayout()
        
        let imageSelectorScreen = ImageSelectorController(collectionViewLayout: layout)
    
        self.navigationController?.pushViewController(imageSelectorScreen, animated: false)
        
    }
    @objc func handleSaveBtn(button: UIButton, event: UIEvent){
      
        
        if pushFromSuperView == false {
            let tabBarController = CustomTabBarController()
            tabBarController.selectedIndex = 3
            tabBarController.tabBar.barTintColor = UIColor.black
            self.tabBarController?.navigationController?.navigationBar.isHidden = true
            self.navigationController?.setViewControllers([tabBarController], animated: false)
            tabBarController.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.navigationController?.popToRootViewController(animated: true)
            return
        }
        
        guard let tapCounts = event.allTouches?.first else {return}
        
        // This prevents the Save Btn from being clicked more then once preventing duplicated data being sent to the database
        if tapCounts.tapCount == 1{
            

            guard let savedProfileName = self.textFieldInput.text else {return}
            var activeProfileArray =  [ProfileModel]()
            
             activeProfileArray = self.profileData.enumerated().filter {
                $0.element.profileName == savedProfileName
                 }.map{$0.element}
            
            if activeProfileArray.count > 0 {
                // Profile Name already Exists
                let cancelAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                let alertController = self.createAlertController(title: AlertMessage.ProfileError.title, message: AlertMessage.ProfileError.message, alertAction: cancelAlertAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }

        if saveBtn.isEnabled == true {
            guard let currentUserID = Firebase.Auth.auth().currentUser?.uid else {return}
           
            guard let textfieldText = textFieldInput.text else {return}
            let isChildToggled = childrenSlider.isOn
            let timeStamp: NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
            
            
            var updateValues:[String: Any] = [:]
            if profileImageURL == nil {
                updateValues = ["ProfileName": textfieldText, "ProfileURL":defaultProfileImageURL, "isChildEnabled": isChildToggled ,"isActive": false, "createdDate": timeStamp]
            } else {
                updateValues = ["ProfileName": textfieldText, "ProfileURL":profileImageURL!, "isChildEnabled": isChildToggled, "isActive": false, "createdDate": timeStamp]
            }
            
            let randomProfileIdentifier = UUID().uuidString
            let profieInfo = [randomProfileIdentifier: updateValues]
            
            self.saveBtn.isUserInteractionEnabled = false
            
            
            self.showActivityIndicator(color: Colors.btnLightGray.withAlphaComponent(0.4), maskType: .custom)
            
            Firebase.Database.database().reference().child("Users").child(currentUserID).child("Profiles").updateChildValues(profieInfo) { (err, ref) in
            
                   if let error = err {
                    print("ERROR HAPPENED", error)
                }
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.40, execute: {
                    self.textFieldInput.resignFirstResponder()
                    SVProgressHUD.dismiss()
                    self.navigationController?.dismiss(animated: false, completion: nil)
              
                })
            }
            
           
         }
            
      }
        
        else {
            print("error")
        }

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        textFieldInput.becomeFirstResponder()

    }
    
    
    func helperMethod(){
             if #available(iOS 13.0, *) {
                 self.isModalInPresentation = true
             }
         }
         

    
}
