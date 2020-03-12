//
//  CustomCollectionViewCell.swift
//  NetflixApp
//
//  Created by Mezut on 24/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var videoInfo: [VideoData] = {
        var video1 = VideoData()
        video1.videoImage = UIImage(named:"bodyguard")
        
        var video2 = VideoData()
        video2.videoImage = UIImage(named:"suits")
        
        var video3 = VideoData()
        video3.videoImage = UIImage(named:"bodyguard")
        
        var video4 = VideoData()
        video4.videoImage = UIImage(named:"suits")
        
        return [video1,video2,video3,video4]
    }()
    
    
    
    let cellId = "cellId"
    var headerCellId = "headerCellId"

    
   
    
    lazy var customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 9.0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(){
        customCollectionView.register(InnerCustomCellNew.self, forCellWithReuseIdentifier: cellId)
        customCollectionView.register(CustomTitleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = customCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath)
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 40)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 3 - 5  , height:self.frame.height / 2 - 10)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InnerCustomCellNew
        cell.videoData = videoInfo[indexPath.row]
        cell.layer.cornerRadius = 3
        cell.layer.masksToBounds = true
        collectionView.scrollsToTop = false
        collectionView.isScrollEnabled = false
        return cell
    }
  
    
    func setupLayout(){

        addSubview(customCollectionView)
        
        NSLayoutConstraint.activate([
            customCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            customCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            customCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        
            ])
    
        
    }
    
    
    
    
}


class CustomTitleHeader: UICollectionViewCell {
    
    let headerLabel: UILabel = {
       let label = UILabel()
        label.text = "My List"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .orange
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            
             headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
             headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
            ])
    }
    
    
}



class InnerCustomCellNew: UICollectionViewCell {
    
    var videoData: VideoData?{
        didSet{
            cellImage.image = videoData?.videoImage
            
        }
    }
    
    let cellImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "bodyguard"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        addSubview(cellImage)
        
        
        NSLayoutConstraint.activate([
            
            cellImage.topAnchor.constraint(equalTo: self.topAnchor),
            cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            cellImage.heightAnchor.constraint(equalTo: self.heightAnchor)
            
            ])
    }
    
    
    
}


