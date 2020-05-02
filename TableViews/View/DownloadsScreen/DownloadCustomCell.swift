//
//  DownloadCustomCell.swift
//  TableViews
//
//  Created by Mezut on 17/01/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase

class DownloadCustomCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var imageUrls =  [VideoData]()
    
    
    
    var downloadScreen: innerDownloadScreen?
    
    let innerCellId = "innerCellId"
    let padding: CGFloat = 10
    
    lazy var innerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = Colors.settingBg
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        innerCollectionView.register(InnerCustomCell.self, forCellWithReuseIdentifier: innerCellId)
       goHome()

        getFirebaseDatabase()
        setupLayout()
    }
    
    func goHome() {
       
    }
    
    
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4 + padding, height: 150)
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: innerCellId, for: indexPath) as? InnerCustomCell
        cell?.videoInformation = imageUrls[indexPath.row]
        return cell!
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       downloadScreen?.goToVideoController(video: imageUrls[indexPath.item])
    }
    
    
    
    
    
    func getFirebaseDatabase(){
        
        
        let firebaseDatabase = Database.database().reference()
        firebaseDatabase.observeSingleEvent(of: .value) { (snapShot) in
            guard let dictionary = snapShot.value as? [String: [Dictionary<String,AnyObject>]] else {return }
            guard let firstItem = dictionary["Videocategories"] else {return}
            guard let videoSection = firstItem[1]["videoData"] else {return}
            guard let videoInformation = videoSection as? [Dictionary<String, AnyObject>] else {return}
            
            
            
            for item in videoInformation {
    
                guard let videoUrl = item["videoUrl"] as? String else {return}
                
                let singleVideo = VideoData()
                singleVideo.videoTitle = videoUrl
                self.imageUrls.append(singleVideo)
     
    
                
            }
            
            
            self.innerCollectionView.reloadData()
            
            
            
            
        }
        
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
