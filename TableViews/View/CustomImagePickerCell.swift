//
//  CustomImagePickerCell.swift
//  TableViews
//
//  Created by Mezut on 31/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class CustomImagePickerCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
   
    private let imageCellID = "IMAGECELLID"

    let ImageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Classics"
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imagePickerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let colletionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.backgroundColor = .clear
        colletionView.showsHorizontalScrollIndicator = false
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        return colletionView
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 135)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagePickerCollectionView.dequeueReusableCell(withReuseIdentifier: imageCellID, for: indexPath)
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupLayout()
    }
    
    func setupCollectionView(){
        imagePickerCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: imageCellID)
    }
    
    func setupLayout(){
        addSubview(ImageTitleLabel)
        addSubview(imagePickerCollectionView)
        
        NSLayoutConstraint.activate([
            
             ImageTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
             ImageTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
             
             imagePickerCollectionView.topAnchor.constraint(equalTo: self.ImageTitleLabel.bottomAnchor, constant: 20),
             imagePickerCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             imagePickerCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             imagePickerCollectionView.heightAnchor.constraint(equalToConstant: 150)

            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
