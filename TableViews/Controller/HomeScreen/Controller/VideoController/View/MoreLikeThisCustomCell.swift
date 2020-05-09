//
//  MoreLikeThisCustomCell.swift
//  TableViews
//
//  Created by Mezut on 01/05/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class MoreLikeThisCustomCell: UICollectionViewCell{
    
    var videoInformation: VideoData? {
        didSet{
            if let videoURL = videoInformation?.videoURL {
                self.videoImage.loadImage(urlString: videoURL)
            }
        }
    }
    

       
    
    var videoImage: CustomImageView = {
       let image = CustomImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.settingBg
        setupLayout()
    }
    
    func setupLayout(){
        addSubview(videoImage)
        
        NSLayoutConstraint.activate([
            videoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoImage.topAnchor.constraint(equalTo: self.topAnchor),
            videoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
