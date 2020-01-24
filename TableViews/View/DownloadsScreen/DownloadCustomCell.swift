//
//  DownloadCustomCell.swift
//  TableViews
//
//  Created by Mezut on 17/01/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class DownloadCustomCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let innerCellId = "innerCellId"
    let padding: CGFloat = 10
    
    lazy var innerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .blue
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        innerCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: innerCellId)
       

    
        setupLayout()
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4 + padding, height: 150)
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: innerCellId, for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
    
    func setupLayout(){
        
        
     
        
        addSubview(innerCollectionView)
        
        NSLayoutConstraint.activate([
            
             innerCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             innerCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
             innerCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             innerCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             
             
            
            ])
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
