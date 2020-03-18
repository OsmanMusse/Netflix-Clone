//
//  SignInContrller.swift
//  NetflixApp
//
//  Created by Mezut on 17/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Firebase

class SignUpScreen: UIViewController, UITextFieldDelegate{
    

    
    lazy var emailTextField: CustomTextField = {
       let textField = CustomTextField()
        print("Hello Woflc")
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: "Email or phone number", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)])
        textField.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        textField.addTarget(self, action: #selector(handleSignUpIndicator), for: .editingChanged)
        textField.layer.cornerRadius = 3
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .white
        textField.tintColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SHOW", for: .normal)   
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(handleshowBtn), for: .touchUpInside)
        button.setTitleColor(UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1), for: .normal)
        return button
    }()
    
  
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)])
        textField.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        textField.addTarget(self, action: #selector(handleSignUpIndicator), for: .editingChanged)
        textField.layer.cornerRadius = 4
        textField.textColor = .white
        textField.tintColor = .white
        textField.isSecureTextEntry = true
        button.frame = CGRect(x: textField.frame.size.width + 30, y: 5, width: 70, height: 70)
        textField.rightView = button
        textField.rightViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    

    
    lazy var signUpButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1).cgColor
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var alreadyAccount: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have an account? Sign In", for: .normal)
        button.addTarget(self, action: #selector(goToSignInScreen), for: .touchUpInside)
        button.setTitleColor(UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signUpButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor =  UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        setupNavigationbar()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "play-button-white").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBackBtn))
        
        setupViews()
        
        
        
        // Setting up the notification to be observed
        
        setupNotification()
        
    }
    
    var stackViewCenterYAnchor: NSLayoutConstraint?
    
    
    func setupViews() {
        
        view.addSubview(stackView)
        view.addSubview(alreadyAccount)
        
        stackViewCenterYAnchor = stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        stackViewCenterYAnchor?.isActive = true
        

        NSLayoutConstraint.activate([
            
             stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
             stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
             stackView.heightAnchor.constraint(equalToConstant: 170),
             
             alreadyAccount.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
             alreadyAccount.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            ])
    }
    
    
    func setupNotification(){
        
        // Get hang of the default notification center of the application
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIApplication.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func handleKeyboardShow(notification: Notification){

        
        if let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIApplication.keyboardFrameBeginUserInfoKey] as? NSValue {
            let cgRect = keyboardFrame.cgRectValue
            print(cgRect.size.width)
            
            stackViewCenterYAnchor?.constant = -30

            UIView.animate(withDuration: 0.3, animations: {
                  self.view.layoutIfNeeded()
            })

        }
    }
    
    @objc func handleKeyboardHide(){
         print("Hello")
    }
    
    @objc func handleBackBtn(){
        print("Back button clicked")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleshowBtn(){
        if passwordTextField.isSecureTextEntry == false {
            passwordTextField.isSecureTextEntry = true
        } else {
            passwordTextField.isSecureTextEntry = false
        }
 
    }
    
    
    @objc func goToSignInScreen(){
        self.navigationController?.pushViewController(SignInScreen(), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("keyboard removed")
        textField.resignFirstResponder()
        
        stackViewCenterYAnchor?.constant = +30
        
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
        return true
    }
    
 
    
    @objc func handleSignUp(){
        guard let email = emailTextField.text, email.characters.count > 0  else {return}
        guard let password = passwordTextField.text, password.characters.count > 0 else {return}
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            if let error = err {
                print("Failed to create useer:", err)
                return
            }
            
            let layout = UICollectionViewFlowLayout()
            // Go to the profile selector to select the your profile
            self.present(ProfileSelector(collectionViewLayout: layout), animated: true, completion: nil)
            print("Successfully Added User",user?.user.uid)
        }
    }
    
    @objc func handleSignUpIndicator(){
         let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
        
        if(isFormValid) {
            signUpButton.backgroundColor = UIColor(red: 229/255, green: 31/255, blue: 19/255, alpha: 1)
            signUpButton.setTitleColor(.white, for: .normal)
        } else {
            signUpButton.setTitleColor(UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1), for: .normal)
            signUpButton.backgroundColor = .clear
        }
    }
    
    
 
    
}
