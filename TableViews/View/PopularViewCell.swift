//
//  MyListViewCell.swift
//  TableViews
//
//  Created by Mezut on 30/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class CustomPopularViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let listVideos: [VideoData] = {
        var video1 = VideoData()
        video1.videoImage = UIImage(named: "Jim-Jeffers-Poster")
        
        let video2 = VideoData()
        video2.videoImage = UIImage(named: "Jim-Jeffereis-this-is-me-poster")
        
        
        let video3 = VideoData()
        video3.videoImage = UIImage(named: "Bill-Buss-Poster")
        
        let video4 = VideoData()
        video4.videoImage = UIImage(named: "Bill-Burr-Poster")
        
        let video5 = VideoData()
        video5.videoImage = UIImage(named: "Sabrina-Poster")
        
        
        let video6 = VideoData()
        video6.videoImage = UIImage(named: "Ozark-netflix-poster")
        
        let video7 = VideoData()
        video7.videoImage = UIImage(named: "Disenchantment-netflix-poster")
        
        let video8 = VideoData()
        video8.videoImage = UIImage(named: "All-the-boys-poster")
        
        let video9 = VideoData()
        video9.videoImage = UIImage(named: "The-kissing-booth-poster")
        
        let video10 = VideoData()
        video10.videoImage = UIImage(named: "black-mirror-poster")
        
        
        return [video1,video2,video3,video4,video5,video6,video7,video8,video9,video10]
        
        
    }()
    
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
        customCollectionView.register(CustomPopularCell.self, forCellWithReuseIdentifier: cellId)
      
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4 + padding , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomPopularCell
        cell.listVideo = listVideos[indexPath.item]
        return cell
    }
    
    
}


class CustomPopularCell: UICollectionViewCell {
    
    var listVideo: VideoData?  {
        didSet {
            imageCell.image = listVideo?.videoImage
        }
    }
    
    let imageCell: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "Jim-Jeffers-Poster"))
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
        addSubview(imageCell)
        
        NSLayoutConstraint.activate([
            
            imageCell.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageCell.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageCell.topAnchor.constraint(equalTo: self.topAnchor),
            imageCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
    }
    
    
}
