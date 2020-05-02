//
//  CustomPreviewsViewCell.swift
//  TableViews
//
//  Created by Mezut on 29/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit


class CustomPreviewsViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    let cellId = "cellId"
    let padding: CGFloat = 10
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let headerLabel: UILabel = {
       let label = UILabel()
        label.text = "Previews"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        customCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.indicatorStyle = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 106, height: 106)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 53
    
        return cell
    }
    
    
    
    func setupLayout(){
        addSubview(headerView)
        addSubview(headerLabel)
        addSubview(customCollectionView)
        
        NSLayoutConstraint.activate([
            
            headerView.widthAnchor.constraint(equalToConstant: self.frame.width),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            
            customCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            customCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            customCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
            ])
        
        
        
        
        
    }
    
    
}


