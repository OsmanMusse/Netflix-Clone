//
//  VideoCell.swift
//  TableViews
//
//  Created by Mezut on 25/01/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    var imageUrl: String? {
        didSet{
            print("There are x amount\(self.imageUrl!.count)")
        }
    }
    
    var videoImageView: UIImageView = {
       let image = UIImageView(image: nil)
        image.backgroundColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    func setupLayout(){
        addSubview(videoImageView)
        
        
        NSLayoutConstraint.activate([
            
            videoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            videoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
