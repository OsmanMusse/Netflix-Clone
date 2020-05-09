//
//  InnerBaseViewCell.swift
//  TableViews
//
//  Created by Mezut on 01/02/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//




import UIKit
import Firebase
import Hero


var videoImageCache = [String: UIImage]()

class InnerBaseViewCell: UICollectionViewCell {

    
    var videoInfo: VideoData? {
        didSet{
            if let videoURL = videoInfo?.videoURL {
                self.customImageView.loadImage(urlString: videoURL)
            }
        }
    }
    
    

    
    var customImageView: CustomImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    
    
    func setupLayout(){
        
    
        addSubview(customImageView)
        
        
        NSLayoutConstraint.activate([
            
            customImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customImageView.topAnchor.constraint(equalTo: self.topAnchor),
            customImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
