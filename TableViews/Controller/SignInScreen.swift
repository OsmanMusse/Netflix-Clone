//
//  SignInContrller.swift
//  NetflixApp
//
//  Created by Mezut on 17/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignInScreen: UIViewController, UITextFieldDelegate{
    
    
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
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
    
    
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1).cgColor
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let recoverButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Recover Password", for: .normal)
        button.setTitleColor(UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let alreadyAccount: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have an account? Sign In", for: .normal)
        button.setTitleColor(UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signInButton,recoverButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor =  UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        setupNavigationbar()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "volume-up-interface-symbol").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBackBtn))
        
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
            stackView.heightAnchor.constraint(equalToConstant: 215),
            
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("keyboard removed")
        textField.resignFirstResponder()
        
        stackViewCenterYAnchor?.constant = +30
        
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if emailTextField.text!.count >= 1 && passwordTextField.text!.count >= 1 {
            signInButton.backgroundColor = UIColor(red: 229/255, green: 31/255, blue: 19/255, alpha: 1)
            signInButton.setTitleColor(.white, for: .normal)
            
        }
        
        return true
    }
    
    @objc func handleSignIn(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(.clear)
        Firebase.Auth.auth().signIn(withEmail: email, password: password) { (dataResult, err) in

            
            if let error = err {
                
                SVProgressHUD.dismiss()
                
                  let alertController = UIAlertController(title: "Sign in", message: "Sorry, we can't find an account with this email address. Please try again or create a new account.", preferredStyle: .alert)
                      let tryAgainAction  =  UIAlertAction(title: "Try Again", style: .default, handler: { (alertAction) in
                          
                      })
                

                  
              alertController.addAction(tryAgainAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            print("SucessFully Login In with user: ", dataResult?.user.uid)
           
            let profileSelectorController = ProfileSelector()
            let navigationController = UINavigationController(rootViewController: profileSelectorController)
            navigationController.modalPresentationStyle = .fullScreen
            SVProgressHUD.dismiss()
            self.present(navigationController, animated: false, completion: nil)
        }
    }
    
    @objc func handleSignUpIndicator(){
         let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
        
        if(isFormValid) {
            signInButton.backgroundColor = UIColor(red: 229/255, green: 31/255, blue: 19/255, alpha: 1)
            signInButton.setTitleColor(.white, for: .normal)
        } else {
            signInButton.setTitleColor(UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1), for: .normal)
            signInButton.backgroundColor = .clear
        }
    }
    
    
    
}
