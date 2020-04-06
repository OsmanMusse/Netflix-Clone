//
//  ProfileSelector.swift
//  TableViews
//
//  Created by Mezut on 17/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase
import Hero




class ProfileSelector: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let profileCellID = "profileCellID"
    
    var userProfileIdRecogizer: [String] = []
    var userProfileIndexPath: Int?
    var profileData = [ProfileModel]()
    
    
    lazy var customCollectionViews: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.allowsMultipleSelection = true
        cv.backgroundColor = .black
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    lazy var editBtn: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.addTarget(self, action: #selector(handleEditingMode), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var doneBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(handleFinishMode), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.alpha = 0.3
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()

    lazy var editStack: UIStackView = {
        let buttonView = UIStackView(arrangedSubviews: [editBtn])
        buttonView.isHidden = false
        buttonView.axis = .horizontal
        buttonView.alignment = .center
        buttonView.spacing = 50
        buttonView.distribution = .fillEqually
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }()
    
    
    lazy var doneStack: UIStackView = {
        let buttonView = UIStackView(arrangedSubviews: [doneBtn])
        buttonView.isHidden = true
        buttonView.axis = .horizontal
        buttonView.alignment = .center
        buttonView.spacing = 50
        buttonView.distribution = .fillEqually
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }()
    
    
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        view.backgroundColor = .black
        customCollectionViews.register(ProfileCustomCell.self, forCellWithReuseIdentifier: profileCellID)
        navigationController?.navigationBar.isHidden = false
        setupNavBar()
        getFirebaseChildremoved()
        getFirebaseChildAdded()
        getFirebaseChildEdited()
        setupLayout()
        
        
    }
    
    
    func setupNavBar(){
        navigationItem.title = "Who's Watching?"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 18)!]
        
    
        let customView = UIBarButtonItem(customView: editStack)
        
        navigationItem.rightBarButtonItems = [customView]
        
        let customView2 = UIBarButtonItem(customView: doneStack)
        
        navigationItem.leftBarButtonItems  =  [customView2]
        
        // Remove the unneeded transparent backgroundColor for the navigationBar
        navigationController?.navigationBar.shadowImage =  UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    
   
 
    func getFirebaseChildAdded(){
        

        
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        
        Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").observe(.childAdded, with: { (snapShot) in

            let userRecognizerID = snapShot.key
            guard let dictionary = snapShot.value as? [String: Any] else {return}
            guard let profileName =  dictionary["ProfileName"] as? String else {return}
            guard let profileURL =  dictionary["ProfileURL"] as? String else {return}
            
            let createUserProfile = ProfileModel(profileName: profileName, profileImage: profileURL)
            
            self.userProfileIdRecogizer.append(userRecognizerID)
            
            self.profileData.append(createUserProfile)
            
            self.customCollectionViews.reloadData()
        
            
        }) { (err) in
            print("ERR == \(err)")
        }
    }
    
    func getFirebaseChildEdited(){
        

        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        
        Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").observe(.childChanged) { (snapShot) in
            guard let dictionary = snapShot.value as? [String: Any] else {return}
            guard let profileName =  dictionary["ProfileName"] as? String else {return}
            guard let profileURL =  dictionary["ProfileURL"] as? String else {return}
            guard let userIndexPath = self.userProfileIndexPath else {return}
            
            let createUserProfile = ProfileModel(profileName: profileName, profileImage: profileURL)
            
            self.profileData.remove(at: userIndexPath)
            
            self.profileData.insert(createUserProfile, at: userIndexPath)
            
            self.customCollectionViews.reloadData()
            
        }
    }
    
    
    func getFirebaseChildremoved(){
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").observe(.childRemoved, with: { (snapShot) in
        
            guard let dictionary = snapShot.value as? [String: Any] else {return}
            guard let profileName =  dictionary["ProfileName"] as? String else {return}
            guard let profileURL =  dictionary["ProfileURL"] as? String else {return}
            
            guard let userIndexPath = self.userProfileIndexPath else {return}
            
            
            self.profileData.remove(at: userIndexPath)
            
            self.userProfileIdRecogizer.remove(at: userIndexPath)
            
            self.userProfileIndexPath = nil
            
            self.customCollectionViews.reloadData()
          
            
            
        }) { (err) in
            print("There an error with the child being removed == \(err)")
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
        -> CGSize {
            if indexPath.item + 1 == collectionView.numberOfItems(inSection: 0) {
                return CGSize(width: 90, height: 90)
            }
        return CGSize(width: 110, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
   
        let cell = customCollectionViews.dequeueReusableCell(withReuseIdentifier: profileCellID, for: indexPath) as! ProfileCustomCell
        
       
        
        cell.profileSelectorScreen = self
    
        let isfirstItem = indexPath.item == 0
        let isfifthItem = indexPath.item == 5
        let isLastItem = indexPath.item + 1 == collectionView.numberOfItems(inSection: 0)

     
        
        
        if isLastItem == false  {
            let indexo = profileData[indexPath.item]
            cell.profileInformation = profileData[indexPath.item]
            cell.hero.id = "skyWalker"
            cell.hero.modifiers = [HeroModifier.cascade()]
            cell.profileImage.hero.modifiers = [.useNormalSnapshot]
            cell.setupDefaultCell()
            return cell
        }

        

         let isEvenIndexPath = indexPath.item % 2 == 0
  
        // Check for the last item in the collectionview
        if indexPath.item > 0 && isLastItem == true   {



            
            if isfirstItem == false && isLastItem == true && isEvenIndexPath == true{
                cell.frame.origin.x = cell.frame.origin.x - 13
            }
            
            reloadEditMode()
            cell.setupProfileCell()
            
            return cell
        }
    
        return cell
        
    }
    
    
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

      // Shows the activity indicator meaning where loging into a profile
      showActivityIndicator(color: Colors.btnLightGray.withAlphaComponent(0.4), maskType: .custom)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            let appTabBarController = CustomTabBarController()
            self.present(appTabBarController, animated: false, completion: nil)
        }
        

        
        let cell = customCollectionViews.cellForItem(at: indexPath) as! ProfileCustomCell
        
        // If the add profile cell is selected
        if cell.profileName.text == "Add Profile" {
            let navigationController = UINavigationController(rootViewController: CreateProfileController())
            self.present(navigationController, animated: false, completion: nil)
        }
        
        // Preventing single selection of cells
        if cell.isSelected == true && editStack.isHidden == false {
            
            cell.shadowView.isHidden = true
            cell.editIcon.isHidden = true
        }
        
        if doneStack.isHidden == false && cell.profileName.text != "Add Profile" {

            userProfileIndexPath = indexPath.item
            let editController = EditProfileController() 
            let cellImageString = profileData[indexPath.item].profileImage
            editController.profileImage.image = profileCachedImages[cellImageString]
            editController.oldProfileURL = cellImageString
            editController.textFieldText = profileData[indexPath.item].profileName
            editController.holdUserIDRecognizer = userProfileIdRecogizer[indexPath.item]
            let navigationController = UINavigationController(rootViewController: editController)
            navigationController.hero.isEnabled = true
            cell.isSelected = false
            
            self.present(navigationController, animated: true, completion: nil)
            cell.shadowView.isHidden = false
            cell.editIcon.isHidden = false
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        
        let cell = customCollectionViews.cellForItem(at: indexPath) as! ProfileCustomCell
        
        // If the add profile cell is selected
        if cell.profileName.text == "Add Profile" {
            let navigationController = UINavigationController(rootViewController: CreateProfileController())
            self.present(navigationController, animated: false, completion: nil)

        }
          
        
        // Preventing single de-selecting of cells
         if doneStack.isHidden == false && cell.profileName.text != "Add Profile" {
            userProfileIndexPath = indexPath.item
            let editController = EditProfileController()
            let cellImageString = profileData[indexPath.item].profileImage
            editController.profileImage.image = profileCachedImages[cellImageString]
            editController.oldProfileURL = cellImageString
            editController.textFieldText = profileData[indexPath.item].profileName
            editController.holdUserIDRecognizer = userProfileIdRecogizer[indexPath.item]
            let navigationController = UINavigationController(rootViewController: editController)
            navigationController.hero.isEnabled = true
            

        self.present(navigationController, animated: true, completion: nil)

            cell.shadowView.isHidden = false
            cell.editIcon.isHidden = false
        }
    }
    
    
       

    func setupLayout(){
        view.addSubview(customCollectionViews)
        view.addSubview(shadowView)
        NSLayoutConstraint.activate([
            
            
            
            customCollectionViews.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 65),
            customCollectionViews.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -65),
            customCollectionViews.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            customCollectionViews.heightAnchor.constraint(equalToConstant: 700),
            
            
            shadowView.widthAnchor.constraint(equalToConstant: customCollectionViews.frame.width),
            shadowView.heightAnchor.constraint(equalToConstant: customCollectionViews.frame.height),
            
            shadowView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            shadowView.topAnchor.constraint(equalTo: self.view.topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            
            
            ])
    }
    
    
    func reloadEditMode(){
        for section in 0..<self.customCollectionViews.numberOfSections {
            for item in 0..<self.customCollectionViews.numberOfItems(inSection: section) {
                // Makes all the items remove themselves from  selected and non selected editing stage
                self.customCollectionViews.deselectItem(at: IndexPath(item: item, section: section), animated: false)
                self.customCollectionViews.selectItem(at: IndexPath(item: item, section: section), animated: false, scrollPosition: .top)
            }
        }
        
    }
    
    @objc func handleEditingMode(){
        editStack.isHidden = true
        doneStack.isHidden = false
        
        navigationItem.title = "Manage Profiles"
        
        for section in 0..<customCollectionViews.numberOfSections {
            // Looping through entire cells except the last one 
            for item in 0..<customCollectionViews.numberOfItems(inSection: section) - 1 {
                customCollectionViews.selectItem(at: IndexPath(item: item, section: section), animated: false, scrollPosition: .top)
            }
        }
        
    }
    
    @objc func handleFinishMode(){
        
        navigationItem.title = "Who's Watching?"
    
        editStack.isHidden = false
        doneStack.isHidden = true
        
        for section in 0..<customCollectionViews.numberOfSections {
            for item in 0..<customCollectionViews.numberOfItems(inSection: section) {
                // Makes all the items remove themselves from  selected and non selected editing stage
                customCollectionViews.selectItem(at: IndexPath(item: item, section: section), animated: false, scrollPosition: .top)
                customCollectionViews.deselectItem(at: IndexPath(item: item, section: section), animated: false)
            }
        }
    }
    
    
 
    
    

    
}
