//
//  VideoViewCell.swift
//  TableViews
//
//  Created by Mezut on 31/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import AVFoundation


class VideoViewCell: UITableViewCell {
    
    let padding: CGFloat = 60
    
    var player: AVPlayer?
    var videoPlayerLayer:CALayer?
    
    let videoPoster: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "The-red-sea-poster"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var videoView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   
    
    lazy var blackView: UIView = {
        var blackView = UIView()
        blackView.backgroundColor = .black
        blackView.layer.cornerRadius = 19
        blackView.isHidden = true
        blackView.backgroundColor = .black
        blackView.translatesAutoresizingMaskIntoConstraints = false
        
        return blackView
    }()
    
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoPoster)
        return view
    }()
    
  
    lazy var soundControls: UIButton = {
       let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "volume-up-interface-symbol").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSound), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var playButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 16.5)
        button.setImage(#imageLiteral(resourceName: "play-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 0)
        button.backgroundColor = .white
        button.layer.cornerRadius = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My List", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 16.5)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor(red: 87/255, green: 87/255, blue: 87/255, alpha: 1)
        button.layer.cornerRadius = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    lazy var buttonStackView: UIView = {
        
        let stackViewContainer = UIView()
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [playButton, listButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackViewContainer.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: stackViewContainer.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: stackViewContainer.trailingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: stackViewContainer.widthAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: stackViewContainer.topAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: stackViewContainer.heightAnchor).isActive = true
        return stackViewContainer
        
        
    }()
    
    
    var isPlaying = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupLayout()
         setupVideoControls()
         setupVideoLauncher()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        addSubview(videoView)
        addSubview(containerView)
        addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            
            videoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            videoView.topAnchor.constraint(equalTo: self.topAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: videoView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: videoView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: videoView.bottomAnchor),
            containerView.topAnchor.constraint(equalTo: videoView.topAnchor),
            
            videoPoster.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            videoPoster.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            videoPoster.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -60),
            videoPoster.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            buttonStackView.bottomAnchor.constraint(equalTo: videoView.bottomAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: videoView.leadingAnchor, constant: 10),
            buttonStackView.trailingAnchor.constraint(equalTo: videoView.trailingAnchor, constant: -10),
            buttonStackView.heightAnchor.constraint(equalToConstant:40)
            
            
            ])
        
        
    }
    
    
    
    
    func setupVideoControls() {
        containerView.addSubview(blackView)
        blackView.addSubview(soundControls)
        
        
        NSLayoutConstraint.activate([
            blackView.trailingAnchor.constraint(equalTo: videoPoster.trailingAnchor, constant: -18),
            blackView.widthAnchor.constraint(equalToConstant: 38),
            blackView.heightAnchor.constraint(equalToConstant: 38),
            blackView.bottomAnchor.constraint(equalTo: videoPoster.bottomAnchor, constant: -10),
            
            soundControls.centerYAnchor.constraint(equalTo: blackView.centerYAnchor),
            soundControls.centerXAnchor.constraint(equalTo: blackView.centerXAnchor),
            
            ])
      
    }
    
    
    
    func setupVideoLauncher(){
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
             player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                        videoView.layer.addSublayer(playerLayer)
             playerLayer.frame = self.bounds
    
            self.videoPlayerLayer = playerLayer
            
              player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            
        }
  
}
    

    
    
    @objc func handleSound(){
        
        if isPlaying{
            player?.pause()
               soundControls.setImage(#imageLiteral(resourceName: "volume-up-interface-symbol").withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            player?.play()
              soundControls.setImage(#imageLiteral(resourceName: "speaker-off").withRenderingMode(.alwaysOriginal), for: .normal)
        }
        isPlaying = !isPlaying
    }

    
   
  
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"{
            // Show back the black container and the control
            videoPoster.isHidden = true
            blackView.isHidden = false
            soundControls.isHidden = false
            isPlaying = true
        }
       
    }



    

    
 
    override func layoutSubviews() {
      super.layoutSubviews()
        containerView.frame = self.bounds
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        let videoBounds = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - padding)
        videoPlayerLayer?.frame = videoBounds
    }

}
