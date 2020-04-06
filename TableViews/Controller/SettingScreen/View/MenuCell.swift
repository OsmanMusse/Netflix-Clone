//
//  MenuCell.swift
//  TableViews
//
//  Created by Mezut on 05/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    
    private let innerCellID = "innerCellID"
    private let cellPadding: CGFloat = 10

    lazy var innerCollectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let manageProfileBtn: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Manage Profiles", for: .normal)
        button.setTitleColor(Colors.btnGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
        button.setImage(#imageLiteral(resourceName: "pencil-2").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right:0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupLayout()
        
        
  
        
    }
    
    func setupCollectionView(){
        innerCollectionView.register(InnerMenuCell.self, forCellWithReuseIdentifier: innerCellID)
        
        if let layout = innerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
            layout.minimumLineSpacing = 22
            layout.scrollDirection = .vertical
        }
      
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: self.frame.width / 5 - cellPadding * 2 , height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: innerCellID, for: indexPath) as! InnerMenuCell
        cell.backgroundColor = .clear
        
        let lastItem = indexPath.item + 1 == innerCollectionView.numberOfItems(inSection: 0)
        
        // Indicating active profile
        if indexPath.item == 2{
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 2
            cell.layer.cornerRadius = 4.5
        }
        
        // Shows the add icon for the add profile cell
        if lastItem == true {
            cell.setupAddProfile()
            return cell
        }
        
        return cell
    }
    
    
    func setupLayout(){
        addSubview(innerCollectionView)
        addSubview(manageProfileBtn)
        
        NSLayoutConstraint.activate([
            innerCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            innerCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            innerCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            innerCollectionView.heightAnchor.constraint(equalToConstant: 125),
            
            manageProfileBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20),
            manageProfileBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
