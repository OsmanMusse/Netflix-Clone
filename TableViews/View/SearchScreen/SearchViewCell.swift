//
//  SearchViewCell.swift
//  TableViews
//
//  Created by Mezut on 30/10/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class SearchViewCell: UICollectionViewCell {
    
    var videoCollection: VideoData? {
        didSet{
        }
    }
    
    
    let listImage: UIImageView = {
        let image = UIImageView()
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
        addSubview(listImage)
        
        NSLayoutConstraint.activate([
            
            listImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            listImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            listImage.topAnchor.constraint(equalTo: self.topAnchor),
            listImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            ])
    }
    
    
}

