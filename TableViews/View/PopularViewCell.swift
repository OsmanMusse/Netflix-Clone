//
//  MyListViewCell.swift
//  TableViews
//
//  Created by Mezut on 30/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class CustomPopularViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    
    let cellId = "cellId"
    let padding: CGFloat = 10
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if let layout = customCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        }
        setupConfig()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    func setupConfig(){
        customCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
      
    }
    
    
    
    func setupLayout(){
        addSubview(customCollectionView)
        
        NSLayoutConstraint.activate([
            
            customCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            customCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            customCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
            ])
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4 + padding , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    
}


