//
//  BaseListViewCell.swift
//  TableViews
//
//  Created by Mezut on 07/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class BaseListViewCell<C: BaseCollectionViewCell>: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var HomeController: HomeScreen?
    
    var videoCategory: VideoCategory? {
        didSet {
            
        }
    }
    
    var videoCount: Int? {
        didSet{

        }
    }
        
    
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
        customCollectionView.register(C.self, forCellWithReuseIdentifier: cellId)
        
        
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
        
        return 4

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4 + padding , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCollectionViewCell
        cell.video = videoCategory?.videoData?[indexPath.item]
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item clicked")
        if let  video = videoCategory?.videoData?[indexPath.row] {
            
            HomeController?.goToVideoController(video: video)
        }
        
    }
    
    
}


class BaseCollectionViewCell: UICollectionViewCell {
    
    var video: VideoData? {
        didSet {
            listImage.image = video?.videoImage
        }
    }
    
    
    let listImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Big-Mouth-Poster"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        addSubview(listImage)
        
        NSLayoutConstraint.activate([
            listImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            listImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            listImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            listImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
            
            ])
    }
    
    
}

