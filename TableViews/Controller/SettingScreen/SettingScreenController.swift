//
//  SettingScreen.swift
//  TableViews
//
//  Created by Mezut on 27/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD





class SettingScreenController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    private let signOutCellID = "signOutCellID"
    private let referCustomCellID = "referCustomCellID"
    private let settingOptionCellID = "settingOptionCellID"
    private let HeaderCellId = "HeaderCellId"
    private let padding:CGFloat = 50
    
    
    let profileMenuController: ProfileMenuController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       let cv = ProfileMenuController(collectionViewLayout: layout)
        return cv
    }()
    
    lazy var profileMenuView: UIView = {
       var profileView = profileMenuController.view!
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    let parentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.alwaysBounceVertical = true
        cv.contentInsetAdjustmentBehavior = .never
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        setupNavBar()
        setupCollectionView()
        setupLayout()
    
    
    }
    
    func setupNavBar(){
       self.setNavigationTransparent()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func setupCollectionView(){
          self.view.backgroundColor = Colors.settingBg
          customCollectionView.register(ReferCustomCell.self, forCellWithReuseIdentifier: referCustomCellID)
          customCollectionView.register(SettingOptionCell.self, forCellWithReuseIdentifier: settingOptionCellID)
          customCollectionView.register(SignOutCell.self, forCellWithReuseIdentifier: signOutCellID)
          customCollectionView.register(SettingScreenHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCellId)
        
        // Configuration of the collectionViewLayout
        
        if let layout = customCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: padding, left: 0, bottom: 0, right: 0)

        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = customCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCellId, for: indexPath) as! SettingScreenHeader
        header.backgroundColor = .clear
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 225)
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 2 {
            showAlertController()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
             return CGSize(width: self.view.frame.width, height: 280)
        } else if indexPath.item == 1 {
            return CGSize(width: self.view.frame.width, height: 250)
        } else {
             return CGSize(width: self.view.frame.width, height: 100)
        }
      
    }
        
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell?
        
        if indexPath.item == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: referCustomCellID, for: indexPath) as! ReferCustomCell
            if let referCustomCell = cell as? ReferCustomCell {
                referCustomCell.settingScreen = self
            }
            cell?.backgroundColor = Colors.chicagoColor
            return cell!
        } else if indexPath.item == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingOptionCellID, for: indexPath)
            return cell!
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: signOutCellID, for: indexPath) as! SignOutCell
            
            if let signOutCell = cell as? SignOutCell {
                signOutCell.settingController = self
                return signOutCell
            }
            return cell!
        }

    }
    
    
    
    func showAlert(){
        let alertController = UIAlertController(title: "Copied to clipboard", message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func showAlertController(){
        let alertController = UIAlertController(title: "Sign Out", message: "Are you sure that you want to sign out?", preferredStyle: .alert)
        let cancelAlertAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let acceptAlertAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
              self.dismiss(animated: true, completion: nil)
            })
        
        alertController.addAction(cancelAlertAction)
        alertController.addAction(acceptAlertAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    func setupLayout(){
        view.addSubview(customCollectionView)
        view.addSubview(parentView)
        view.addSubview(profileMenuView)
                
        
        NSLayoutConstraint.activate([
            
          
            customCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            customCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            customCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            
            
            parentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            parentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            parentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            parentView.heightAnchor.constraint(equalToConstant: 225),
            
            profileMenuView.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor),
            profileMenuView.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor),
            profileMenuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            profileMenuView.heightAnchor.constraint(equalToConstant: parentView.frame.width),
            
            
            
            
            ])
    }

}
