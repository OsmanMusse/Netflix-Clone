//
//  BaseViewCell.swift
//  TableViews
//
//  Created by Mezut on 01/02/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//




import UIKit
import Firebase



class BaseViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var imageUrls =  [VideoData]()
    
    
    
    var homeScreen: HomeScreen?
    
    let innerCellId = "innerCellId"
    let padding: CGFloat = 10
    
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
        label.text = "My List"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        innerCollectionView.register(InnerBaseViewCell.self, forCellWithReuseIdentifier: innerCellId)

        
        getFirebaseDatabase()
        setupLayout()
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4 + padding, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: innerCellId, for: indexPath) as? InnerBaseViewCell
        cell?.videoInformation = imageUrls[indexPath.row]
        return cell!
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeScreen?.goToVideoController(video: imageUrls[indexPath.item], allowScreenTransitionAnimation: true, allowCellAnimation: true)
    }
    
    
    
    
    
    func getFirebaseDatabase(){
        
        
        let firebaseDatabase = Database.database().reference()
        firebaseDatabase.observeSingleEvent(of: .value) { (snapShot) in
            guard let dictionary = snapShot.value as? [String: [Dictionary<String,AnyObject>]] else {return }
            guard let firstItem = dictionary["Videocategories"] else {return}
            guard let videoSection = firstItem[0] ["videoData"] as? Dictionary<String,Any>  else {return}

            

            
      
            
            for item in videoSection {
                
                guard let castedValue = item.value as? Dictionary<String,AnyObject> else {return}
                guard let videoURLValue = castedValue["videoURL"] as? String else {return}
                
    

                let myListVideo = VideoData()
                
                myListVideo.videoName = videoURLValue
                self.imageUrls.append(myListVideo)
                
                
                
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
