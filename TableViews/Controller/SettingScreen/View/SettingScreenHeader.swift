//
//  SettingScreenHeader.swift
//  TableViews
//
//  Created by Mezut on 04/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class SettingScreenHeader: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
   
    
    private let menuCellCustomID = "menuCellCustomID"
    
    var settingScreen: SettingScreenController?
    
    lazy var innerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        cv.alwaysBounceHorizontal = false
        cv.alwaysBounceVertical = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupCollectionView()
        setupLayout()
        
    }
    

    
    func setupCollectionView(){
        innerCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuCellCustomID)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height:self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: menuCellCustomID, for: indexPath) as! MenuCell
        cell.backgroundColor = Colors.settingBg
        cell.settingHeader = self   
        cell.cellDelegate = self
        return cell
    }
    
    func goToCreatController(){
        let viewController = UIViewController()
        let nv = UINavigationController(rootViewController: CreateProfileController())
        nv.modalPresentationStyle = .pageSheet
        viewController.view.backgroundColor = UIColor.black
        self.settingScreen?.present(nv, animated: true, completion: nil)

    }
    
    func goToRootViewController(){
        self.settingScreen?.tabBarController?.selectedIndex = 0
    }
    
    func setupLayout(){
      addSubview(innerCollectionView)
        
        NSLayoutConstraint.activate([
            
            innerCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            innerCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            innerCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            innerCollectionView.heightAnchor.constraint(equalToConstant: self.frame.height),
            
            ])
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


extension SettingScreenHeader: MenuCellDelegate {
    func didTapProfileImage(profileData: ProfileModel) {
        
    }
    
    func didTapProfileBtn(viewControllerToPresent: UIViewController) {
        
            if let profileController = viewControllerToPresent as? ProfileSelector {
                profileController.pushFromSuperView = false
                profileController.handleEditingMode()
                let navigationController = UINavigationController(rootViewController: profileController)
               self.settingScreen?.present(navigationController, animated: true, completion: nil)
               return
            }
        
        // Action for the Manage Profile Btn
    
        
        // Action for the Add Profile Btn
        if let createController = viewControllerToPresent as? CreateProfileController {
             let profileSelectorNav = UINavigationController(rootViewController: ProfileSelector())
            self.settingScreen?.present(profileSelectorNav, animated: true, completion: {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.10 , execute: {
                    let createControllerNav = UINavigationController(rootViewController: createController)
                    createController.pushFromSuperView = false
                  profileSelectorNav.present(createControllerNav, animated: false, completion: nil)
                    
                })
            })
            
        }
        
//        self.settingScreen?.present(navigationController, animated: true, completion: nil)
        
        
    }
    
    
}
