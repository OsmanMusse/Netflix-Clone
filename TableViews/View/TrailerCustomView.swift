//
//  TrailerGrid.swift
//  TableViews
//
//  Created by Mezut on 26/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class TrailerCustomView: UICollectionViewCell {
    
 
    
    
    var videoCategory: VideoCategory? {
        didSet {
            if let trailerImage = videoCategory?.videoData?[0].videoTrailer?[0].videoName {
                videoImage.image = trailerImage
            }
            
            if let trailerTitle = videoCategory?.videoData?[0].videoTrailer?[0].videoTitle {
                videoTitle.text = trailerTitle
            }
        }
    }
    
    var videoImage: UIImageView  = {
        var image = UIImageView(image: #imageLiteral(resourceName: "suits"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var videoPlayBtn: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "PlayBtn"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var videoTitle: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
   
        
    }
    
    
    func setupLayout(){
        addSubview(videoImage)
        addSubview(videoPlayBtn)
        addSubview(videoTitle)
        
        NSLayoutConstraint.activate([
            videoImage.topAnchor.constraint(equalTo: self.topAnchor),
            videoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoImage.heightAnchor.constraint(equalToConstant: 200),
            
            videoPlayBtn.centerXAnchor.constraint(equalTo: videoImage.centerXAnchor),
            videoPlayBtn.centerYAnchor.constraint(equalTo: videoImage.centerYAnchor),
            
            videoTitle.topAnchor.constraint(equalTo: videoImage.bottomAnchor, constant: 8),
            videoTitle.leadingAnchor.constraint(equalTo: videoImage.leadingAnchor)
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
