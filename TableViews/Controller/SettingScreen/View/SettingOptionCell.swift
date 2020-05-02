//
//  SettingOptionCell.swift
//  TableViews
//
//  Created by Mezut on 05/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class SettingOptionCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
 
    private let settingCellID = "settingCellID"
   
    
    private lazy var innerCollectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.alwaysBounceVertical = false
        cv.delegate = self
        cv.dataSource = self
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
        innerCollectionView.register(InnerSettingCell.self, forCellWithReuseIdentifier: settingCellID)
        
        // Configure CollectionView
        
        if let layout = innerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileConfigurationOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let profileConfigurationCount = CGFloat(ProfileConfigurationOptions.allCases.count)
         return CGSize(width: self.frame.width, height: self.frame.height / profileConfigurationCount)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: settingCellID, for: indexPath) as! InnerSettingCell
        
        let lastItem = indexPath.item + 1 == innerCollectionView.numberOfItems(inSection: 0)
        let settingOptionArray = ProfileConfigurationOptions.allCases
        
        if lastItem == true {
            cell.underlineView.isHidden = true
        }
        
        for item in settingOptionArray {
            cell.settingLabel.text = settingOptionArray[indexPath.item].text
            cell.settingIcon.image = settingOptionArray[indexPath.item].icon
            return cell
        }
        
        
        return cell
    }

    
    func setupLayout(){
        addSubview(innerCollectionView)
        
        NSLayoutConstraint.activate([
            innerCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            innerCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            innerCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            innerCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            

            
            
            ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
