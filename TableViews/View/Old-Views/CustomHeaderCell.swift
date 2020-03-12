//
//  CustomHeaderCell.swift
//  NetflixApp
//
//  Created by Mezut on 21/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class CustomHeaderCell: UICollectionViewCell, UICollectionViewDelegate {
    
    let customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    let headerImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "netflix-logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "testing"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    let backgroundImageShadow: UIView = {
       let view = UIView()
//        view.backgroundColor = .black
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 10.0, height: 3.0)
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let listLabel: UILabel = {
        let label = UILabel()
        label.text = "My List"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var redView: UIView = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "tick").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonLabel = UILabel()
        buttonLabel.text = "My List"
        buttonLabel.font = UIFont.systemFont(ofSize: 12)
        buttonLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
//        view.backgroundColor = .red
        
        view.addSubview(button)
        view.addSubview(buttonLabel)
        
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
        buttonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
        
    }()
    
    
    let cellId = "cellId"

    let blueView: UIView = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.setImage(#imageLiteral(resourceName: "play-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 13)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        let view = UIView()
//        view.backgroundColor = .blue
        
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 85).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        return view
    }()
    
    let greenView: UIView = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonLabel = UILabel()
        buttonLabel.text = "Info"
        buttonLabel.font = UIFont.systemFont(ofSize: 12)
        buttonLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
//        view.backgroundColor = .green
        
        view.addSubview(button)
        view.addSubview(buttonLabel)
        
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
        buttonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        return view
    }()
    
    lazy var videoControlOptionStack: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [redView, blueView, greenView])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customCollectionView.delegate = self
        setupCollectionView()
        setupLayout()
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupCollectionView(){
        customCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    
    func setupLayout(){
        addSubview(headerImage)
        addSubview(backgroundImageShadow)
        addSubview(videoControlOptionStack)
       
    
        NSLayoutConstraint.activate([
              headerImage.topAnchor.constraint(equalTo: self.topAnchor),
              headerImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
              headerImage.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0),
              headerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              headerImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              
              backgroundImageShadow.topAnchor.constraint(equalTo: headerImage.topAnchor),
              backgroundImageShadow.bottomAnchor.constraint(equalTo: headerImage.bottomAnchor),
              backgroundImageShadow.leadingAnchor.constraint(equalTo: headerImage.leadingAnchor),
              backgroundImageShadow.trailingAnchor.constraint(equalTo: headerImage.trailingAnchor),
              
              videoControlOptionStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
              videoControlOptionStack.heightAnchor.constraint(equalToConstant: 70),
              videoControlOptionStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
              videoControlOptionStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  0),
              
           
            ])
    }
}

