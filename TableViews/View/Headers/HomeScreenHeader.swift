//
//  HomeScreenHeader.swift
//  TableViews
//
//  Created by Mezut on 04/02/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase

class HomeScreenHeader: UICollectionViewCell {
    

    
    var imagePoster: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    var firstCatergory: UILabel = {
       let label = UILabel()
        label.text = "Exciting"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var secondCategory: UILabel = {
        let label = UILabel()
        label.text = "Nordic Noir"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var thirdCategory: UILabel = {
        let label = UILabel()
        label.text = "Mystery"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var fourthCategory: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    var addIconBtn: UIButton = {
       let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false

        

        
            return button
        
    }()
   

    
    var heroPlayBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 16.5)
        button.setImage(#imageLiteral(resourceName: "play-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.backgroundColor = .white
        button.layer.cornerRadius = 2
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.widthAnchor.constraint(equalToConstant: 135).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return button
    }()
    
    
    var moreInfoBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    lazy var myListStackView: UIStackView = {
        var myListLabel = UILabel()
        myListLabel.text = "My List"
        myListLabel.textColor = Colors.lightGray
        myListLabel.font = UIFont.boldSystemFont(ofSize: 14)
        myListLabel.translatesAutoresizingMaskIntoConstraints = false
        

       let stackview = UIStackView(arrangedSubviews: [addIconBtn, myListLabel])
        stackview.distribution = .fillProportionally
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        return stackview
    }()
    
    
    lazy var infoStackView: UIStackView = {
        var infoLabel = UILabel()
        infoLabel.text = "Info"
        infoLabel.textColor = Colors.lightGray
        infoLabel.font = UIFont.boldSystemFont(ofSize: 14)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let stackview = UIStackView(arrangedSubviews: [moreInfoBtn, infoLabel])
        stackview.distribution = .fillProportionally
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        return stackview
    }()
    
    
    
     lazy var videoControlsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [myListStackView, heroPlayBtn,infoStackView])
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupHeroImage()
    }
  
    
    func setupHeroImage(){
        
        
        let firebaseDatabase = Database.database().reference()
        firebaseDatabase.observeSingleEvent(of: .value) { (snapShot) in
            guard let dictionary = snapShot.value as? [String: [Dictionary<String,AnyObject>]] else {return }
            guard let firstItem = dictionary["Videocategories"] else {return}
            guard let videoSection = firstItem[3]["videoData"] else {return}
            guard let videoInformation = videoSection as? [Dictionary<String, AnyObject>] else {return}
            guard let videoUrl = videoInformation[0]["videoUrl"] as? String else {return}
            
            
            guard let url = URL(string: videoUrl) else {return}
                
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let imageData = data else {return}
                    
                    let constructedImage = UIImage(data: imageData)
                    
                    DispatchQueue.main.async {
                        self.imagePoster.image = constructedImage
                    }
                    
                    }.resume()
    }
        
        
    }
    
    
   
    
    
    
    func setupLayout(){
        
        let categoryListStackView = UIStackView(arrangedSubviews: [firstCatergory, secondCategory, thirdCategory, fourthCategory])
        categoryListStackView.axis = .horizontal
        categoryListStackView.distribution = .fill
        categoryListStackView.spacing = 12
        categoryListStackView.translatesAutoresizingMaskIntoConstraints = false
        
       addSubview(imagePoster)
        addSubview(categoryListStackView)
        addSubview(videoControlsStackView)
        
        NSLayoutConstraint.activate([
            
            imagePoster.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imagePoster.topAnchor.constraint(equalTo: self.topAnchor),
            imagePoster.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imagePoster.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            categoryListStackView.centerXAnchor.constraint(equalTo: imagePoster.centerXAnchor),
            categoryListStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70),
            categoryListStackView.widthAnchor.constraint(equalToConstant: 253),
            
            videoControlsStackView.centerXAnchor.constraint(equalTo: categoryListStackView.centerXAnchor),
            videoControlsStackView.topAnchor.constraint(equalTo: categoryListStackView.bottomAnchor, constant: 5),
            videoControlsStackView.widthAnchor.constraint(equalToConstant: self.frame.width),
            videoControlsStackView.heightAnchor.constraint(equalToConstant: 60)
            
            
            
            ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
