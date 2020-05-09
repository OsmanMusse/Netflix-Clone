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

    var videoData: VideoCategory? {
        didSet{
            headerLabel.text = videoData?.name
            
        }
    }
    
    var videoInfo: [VideoData]? {
        didSet{
          headerLabel.text = "My List"
       }
    }
    
    
    
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
        label.font = UIFont(name: "Helvetica-Bold", size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        innerCollectionView.register(InnerBaseViewCell.self, forCellWithReuseIdentifier: innerCellId)
  
        setupLayout()
    }
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let videoCount = videoData?.videoData?.count, videoCount > 0 {
            return videoCount
        } else {
            if let videoCount = videoInfo?.count {
            return videoCount
        }
    }
            return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if videoData == nil {
            let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: innerCellId, for: indexPath) as! InnerBaseViewCell
            cell.videoInfo = videoInfo?[indexPath.item]
            return cell
        } else {
            let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: innerCellId, for: indexPath) as! InnerBaseViewCell
            cell.videoInfo = videoData?.videoData?[indexPath.item]
            return cell
        }
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = innerCollectionView.cellForItem(at: indexPath) as! InnerBaseViewCell
//        guard let specificVideo = videoData?.videoData?[indexPath.item] else {return}
//        homeScreen?.goToVideoController(video: specificVideo, allowScreenTransitionAnimation: false, allowCellAnimation: false)
//    }
    
    
    
    func setupLayout(){
        
        addSubview(headerView)
        addSubview(headerLabel)
        addSubview(innerCollectionView)
        
        NSLayoutConstraint.activate([
            
            
            headerView.widthAnchor.constraint(equalToConstant: self.frame.width),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -10),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
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
