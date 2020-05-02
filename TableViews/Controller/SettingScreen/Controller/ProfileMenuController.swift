//
//  ProfileMenuController.swift
//  TableViews
//
//  Created by Mezut on 04/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit



class ProfileMenuController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let menuCellID = "menuCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupLayout()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func setupCollectionView(){
        collectionView.backgroundColor = Colors.settingBg
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = false

        
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuCellID)
        
        // Configuration of the collectionViewLayout
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 125)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellID, for: indexPath)
        return cell
    }
    
    
    func setupLayout(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
     NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        collectionView.heightAnchor.constraint(equalToConstant: 225),
        
        ])
    }
}

