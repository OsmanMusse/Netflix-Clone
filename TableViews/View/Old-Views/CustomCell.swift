//
//  CustomCell.swift
//  NetflixApp
//
//  Created by Mezut on 16/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class CustomCellNew: UICollectionViewCell {
    
    var cellData: CarouselData? {
        didSet {
            label.text = cellData?.title
            descriptionLabel.text = cellData?.description
        }
    }
    
    
    let carouselBtn: UIPageControl = {
        let carouselDots = UIPageControl()
        carouselDots.currentPage = 0
        carouselDots.numberOfPages = 4
        carouselDots.currentPageIndicatorTintColor = Colors.mainRed
        carouselDots.pageIndicatorTintColor = Colors.darkGray
        carouselDots.translatesAutoresizingMaskIntoConstraints = false
        return carouselDots
    }()
    
    lazy var signInButton: UIButton = {
      let button = UIButton(type: .system)
        button.setTitle("SIGN IN", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Colors.mainRed
        button.layer.cornerRadius = 1
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "CenterXAnchor"
        label.numberOfLines = 3
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "SFUIDisplay-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UITextView = {
       let textView = UITextView()
        textView.text = ""
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    
    var topConstraint: NSLayoutConstraint?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    func setupLayout(){
        
        addSubview(carouselBtn)
        addSubview(signInButton)
        
        addSubview(label)
        addSubview(descriptionLabel)
        
         topConstraint = descriptionLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: -40)
        topConstraint?.isActive = true
        
        
      NSLayoutConstraint.activate([
        
           carouselBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
           carouselBtn.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -8),
            
            signInButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            signInButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            signInButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -53),
            signInButton.heightAnchor.constraint(equalToConstant: 43),
            
            
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 220),
            label.heightAnchor.constraint(equalToConstant: 150),
            
        
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 250),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 170)
            ])
    }
    
    
}
