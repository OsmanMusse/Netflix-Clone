//
//  TrailerGrid.swift
//  TableViews
//
//  Created by Mezut on 26/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Firebase

class TrailerCustomView: UICollectionViewCell {
    
 
    var videoController: SingleVideoController?
    
    var videoInformation: VideoTrailer? {
        didSet {
            
            if let videoTrailerText = videoInformation?.videoTitle, let videoURL = videoInformation?.videoURL {
                self.videoTitle.text = videoTrailerText
                self.videoImage.loadImage(urlString: videoURL)
            }
        }
    }
    
    var videoImage: CustomImageView  = {
        var image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var videoPlayBtn: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "PlayBtn"))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleVideoPlay))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGesture)
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
    
    
     @objc private func handleVideoPlay(){
        let videoLauncher = VideoLauncher()
        videoLauncher.launchVideoPlayer(videoInformation: nil, videoTrailer:videoInformation)
        let rotateRight = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(rotateRight, forKey: "orientation")
        
    }
    
    
    func setupLayout(){
        addSubview(videoImage)
        addSubview(videoPlayBtn)
        addSubview(videoTitle)
        
        NSLayoutConstraint.activate([
            videoImage.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            videoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoImage.heightAnchor.constraint(equalToConstant: 260),
            
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
