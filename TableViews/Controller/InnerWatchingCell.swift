//
//  InnerWatchingCell.swift
//  TableViews
//
//  Created by Mezut on 03/02/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//



import UIKit
import Firebase
import  Hero




class InnerWatchingCell: UICollectionViewCell {
    
    var videoInformation: VideoData? {
        didSet{
            
        }
    }
    
    
    var watchinVideoImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "van-heisling-2"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    var watchingVideoBtn: UIImageView = {
        let playBtn = UIImageView(image: #imageLiteral(resourceName: "PlayBtn"))
        playBtn.translatesAutoresizingMaskIntoConstraints = false
        return playBtn
    }()
    
    var innerBlackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
  
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    
    
    func setupLayout(){
        

        addSubview(watchinVideoImage)
        addSubview(watchingVideoBtn)
        addSubview(innerBlackView)
        
        
        
        NSLayoutConstraint.activate([
            
    
            
                        watchinVideoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                        watchinVideoImage.topAnchor.constraint(equalTo: self.topAnchor),
                        watchinVideoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                        watchinVideoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
                        watchingVideoBtn.centerXAnchor.constraint(equalTo: watchinVideoImage.centerXAnchor),
                        watchingVideoBtn.centerYAnchor.constraint(equalTo: watchinVideoImage.centerYAnchor),
            
                        innerBlackView.bottomAnchor.constraint(equalTo: watchinVideoImage.bottomAnchor),
                        innerBlackView.leadingAnchor.constraint(equalTo: watchinVideoImage.leadingAnchor),
                        innerBlackView.trailingAnchor.constraint(equalTo: watchinVideoImage.trailingAnchor),
                        innerBlackView.heightAnchor.constraint(equalToConstant: 35),
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
