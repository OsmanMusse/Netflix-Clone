//
//  HomeScreenHeader.swift
//  TableViews
//
//  Created by Mezut on 04/02/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class HomeScreenHeader: UICollectionViewCell {
    
    
    var imagePoster: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "The-Stranger-Header"))
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
    
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
   
    
    
    
    func setupLayout(){
        
        let categoryListStackView = UIStackView(arrangedSubviews: [firstCatergory, secondCategory, thirdCategory, fourthCategory])
        categoryListStackView.axis = .horizontal
        categoryListStackView.distribution = .fill
        categoryListStackView.spacing = 12
//        categoryListStackView.alignment = .center
        categoryListStackView.translatesAutoresizingMaskIntoConstraints = false
        
       addSubview(imagePoster)
        addSubview(categoryListStackView)
        
        NSLayoutConstraint.activate([
            
            imagePoster.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imagePoster.topAnchor.constraint(equalTo: self.topAnchor),
            imagePoster.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imagePoster.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            categoryListStackView.centerXAnchor.constraint(equalTo: imagePoster.centerXAnchor),
            categoryListStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),            categoryListStackView.widthAnchor.constraint(equalToConstant: 253),
            
            
            ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
