//
//  MoreLikeThisCustomView.swift
//  TableViews
//
//  Created by Mezut on 01/05/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase

class MoreLikeThisCustomView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    private let cellID = "cellID"
    private let padding: CGFloat = 3
    
    var videoCategory: String?
    var videoInformation: [VideoData] = []
    var singleVideoController: SingleVideoController?
    
     lazy private var  customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var overlayAnimationView: UIView = {
           let view = UIView()
           let tap = UITapGestureRecognizer(target: self, action: #selector(handleModalExit))
           view.addGestureRecognizer(tap)
           view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
           view.isHidden = true
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videoInformation.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MoreLikeThisCustomCell
        cell.videoInformation = videoInformation[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 3 - padding * 2, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Do something here when cell is clicked
        let cell = customCollectionView.cellForItem(at: indexPath) as! MoreLikeThisCustomCell
        cell.videoInformation?.videocategory = videoCategory
        singleVideoController?.goToVideoController(video: cell.videoInformation!)
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupLayout()
    }
    
    
    func setupCollectionView(){
        customCollectionView.register(MoreLikeThisCustomCell.self, forCellWithReuseIdentifier: cellID)
        customCollectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        if let layout = customCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 0
        }
    }
    
    @objc func handleModalExit(){
        let notification = Notification(name: NotificationName.OverlayViewDidTap.name)
        NotificationCenter.default.post(notification)
    }
    
 
    func setupLayout(){
        addSubview(customCollectionView)
        addSubview(overlayAnimationView)
        NSLayoutConstraint.activate([
        
            customCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            overlayAnimationView.topAnchor.constraint(equalTo: self.topAnchor),
            overlayAnimationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            overlayAnimationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            overlayAnimationView.heightAnchor.constraint(equalToConstant: 800),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




