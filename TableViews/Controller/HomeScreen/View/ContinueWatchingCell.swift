//
//  ContinueWatchingCell.swift
//  TableViews
//
//  Created by Mezut on 03/02/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase




class ContinueWatchingCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var imageUrls =  [VideoData]()
    
    
    
    var homeScreen: HomeScreen?
    
    let InnerWatchinCellId = "InnerWatchinCellId"
    let padding: CGFloat = 18
    
    lazy var innerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = Colors.settingBg
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Continue Watching for Mascuud"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        innerCollectionView.register(InnerWatchingCell.self, forCellWithReuseIdentifier: InnerWatchinCellId)
        
        
        getFirebaseDatabase()
        setupLayout()
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4 + padding, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: InnerWatchinCellId, for: indexPath) as? InnerWatchingCell
        cell?.videoInformation = imageUrls[indexPath.row]
        cell?.homeScreenTeller = homeScreen
        return cell!
    }
    
    
    

    
    
    
    
    
    func getFirebaseDatabase(){
        
        
        let firebaseDatabase = Database.database().reference()
        firebaseDatabase.observeSingleEvent(of: .value) { (snapShot) in
            guard let dictionary = snapShot.value as? [String: [Dictionary<String,AnyObject>]] else {return }
            guard let firstItem = dictionary["Videocategories"] else {return}
            guard let videoSection = firstItem[2]["videoData"] else {return}
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
        
        addSubview(headerView)
        addSubview(headerLabel)
        addSubview(innerCollectionView)
        
        NSLayoutConstraint.activate([
            
            
            headerView.widthAnchor.constraint(equalToConstant: self.frame.width),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.bottomAnchor.constraint(equalTo: self.topAnchor),
            
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5),
            
            
            innerCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            innerCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            innerCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            innerCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            
            ])
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
