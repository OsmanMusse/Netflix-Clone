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
    
    var homeScreenTeller: HomeScreen? {
        didSet{
        }
    }
    
    var videoInformation: VideoData? {
        didSet{
            
            guard let urlString = videoInformation?.videoTitle else {return}
            
            guard let url = URL(string: urlString) else {return}
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let imageData = data else {return}
                
                let constructedImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.watchinVideoImage.image = constructedImage
                }
                
            }.resume()
        }
    }
    
    
    var watchinVideoImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "iron-man"))
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
    
    
    lazy var moreInfoIcon: UIImageView =  {
       let image = UIImageView(image: #imageLiteral(resourceName: "info-icon"))
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleInfoIcon)))
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var outerSliderView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 56/255, green: 57/255, blue: 56/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var innerSliderView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    var seasonEpiosdeLabel: UILabel = {
       let label = UILabel()
        label.text = "S1:E6"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = Colors.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
  
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        
    }
    
    
    
    @objc func handleInfoIcon(){
        guard let unwrappedVideoInformation = videoInformation else {return}
        homeScreenTeller?.goToVideoController(video: unwrappedVideoInformation, allowScreenTransitionAnimation: true, allowCellAnimation: false)
    }
    
    
    func setupLayout(){
        

        addSubview(watchinVideoImage)
        addSubview(watchingVideoBtn)
        addSubview(innerBlackView)
        addSubview(outerSliderView)
        outerSliderView.addSubview(innerSliderView)
        innerBlackView.addSubview(seasonEpiosdeLabel)
        innerBlackView.addSubview(moreInfoIcon)
        
        
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
                        
                        outerSliderView.widthAnchor.constraint(equalToConstant: innerBlackView.frame.width),
                        outerSliderView.heightAnchor.constraint(equalToConstant: 3),
                        outerSliderView.leadingAnchor.constraint(equalTo: innerBlackView.leadingAnchor),
                        outerSliderView.trailingAnchor.constraint(equalTo: innerBlackView.trailingAnchor),
                        outerSliderView.bottomAnchor.constraint(equalTo: innerBlackView.topAnchor),
                        
                        innerSliderView.widthAnchor.constraint(equalToConstant: outerSliderView.frame.width),
                        innerSliderView.heightAnchor.constraint(equalToConstant: 3),
                        innerSliderView.leadingAnchor.constraint(equalTo: outerSliderView.leadingAnchor),
                        innerSliderView.trailingAnchor.constraint(equalTo: outerSliderView.trailingAnchor, constant: -20),
                        innerSliderView.topAnchor.constraint(equalTo: outerSliderView.topAnchor),
                        
                        seasonEpiosdeLabel.leadingAnchor.constraint(equalTo: innerBlackView.leadingAnchor, constant: 6),
                        seasonEpiosdeLabel.centerYAnchor.constraint(equalTo: innerBlackView.centerYAnchor),
                        
                        moreInfoIcon.trailingAnchor.constraint(equalTo: innerBlackView.trailingAnchor, constant: -6),
                        moreInfoIcon.centerYAnchor.constraint(equalTo: innerBlackView.centerYAnchor),
                        
                        
                        
                        
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
