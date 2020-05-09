//
//  VideoOptionCell.swift
//  TableViews
//
//  Created by Mezut on 19/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class VideoOptionCell: UICollectionViewCell {
    
    
    var singleVideoController: SingleVideoController?
    

    
    lazy var videoImage: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "druken-watermelon-ep1"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.addSubview(videoImageBtn)
   
        
        videoImageBtn.centerXAnchor.constraint(equalTo: image.centerXAnchor).isActive = true
        videoImageBtn.centerYAnchor.constraint(equalTo: image.centerYAnchor).isActive = true
        return image
    }()
    
    var videoImageBtn: UIButton = {
       let playBtn = UIButton(type: .system)
        playBtn.setImage(#imageLiteral(resourceName: "PlayBtn").withRenderingMode(.alwaysOriginal), for: .normal)
        playBtn.translatesAutoresizingMaskIntoConstraints = false
        return playBtn
        
    }()
    
    var videoTime: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "44m"
        label.textColor = Colors.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videoTitle: UITextView = {
   
       let label = UITextView()
        label.textContainerInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        label.text = "1. Drunken Watermelon"
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.centerTextVertically()
        label.isUserInteractionEnabled = false
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        label.addSubview(videoTime)
        
        videoTime.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 10).isActive = true
        videoTime.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40).isActive = true
        
        return label
    }()
    
    var downloadIcon: UIView = {
        let icon = UIButton(type: .system)
        icon.setImage(#imageLiteral(resourceName: "download-icon").withRenderingMode(.alwaysOriginal), for: .normal)
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        view.addSubview(icon)
        
        icon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var videoDescription: UILabel = {
       let label = UILabel()
        label.text = "A botched restaurant order makes Kai a target of Triad members, who are unaware of his familty connections -- and his new status as the Wu Assassin."
        label.textColor = Colors.lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var videoStackView: UIStackView = {
        
        videoImage.widthAnchor.constraint(equalToConstant: 175).isActive = true
        videoTitle.widthAnchor.constraint(equalToConstant: 125).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [videoImage, videoTitle, downloadIcon])
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupLayout()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handeClick)))
        self.isOpaque = false
    }
    
    @objc func handeClick(){
        let notification = Notification(name: NotificationName.OverlayViewDidTap.name)
        NotificationCenter.default.post(notification)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout() {
        addSubview(videoStackView)
        addSubview(videoDescription)
        
        NSLayoutConstraint.activate([
          
            videoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoStackView.heightAnchor.constraint(equalToConstant: 110),
            videoStackView.topAnchor.constraint(equalTo: self.topAnchor),
            
            videoDescription.topAnchor.constraint(equalTo: videoStackView.bottomAnchor, constant: 10),
            videoDescription.leadingAnchor.constraint(equalTo: videoStackView.leadingAnchor),
            videoDescription.trailingAnchor.constraint(equalTo: videoStackView.trailingAnchor),
          
            ])
    }
    

    
    override func layoutSubviews() {
        videoTitle.centerTextVertically()
    }
    
    
    
}



