//
//  UserUsageCell.swift
//  TableViews
//
//  Created by Mezut on 09/10/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class UserUsageCell: UICollectionViewCell {
    
    let phoneName: UILabel = {
       let label = UILabel()
        label.text = "iPhone12,3"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var parentView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var usedView:  UIStackView = {
        
        let view = UIView()
        view.backgroundColor = Colors.usedBarBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Used"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 148/255, green: 148/255, blue: 148/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
      
        
        let stackView = UIStackView(arrangedSubviews: [view, label])
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
     
   
        
        view.widthAnchor.constraint(equalToConstant: 11).isActive = true
        view.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        return stackView
    }()
    
    var netflixView: UIStackView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 80/255, green: 139/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Neflix"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 148/255, green: 148/255, blue: 148/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [view, label])
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        view.widthAnchor.constraint(equalToConstant: 11).isActive = true
        view.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        return stackView
    }()
    
    var freeView: UIStackView = {
       
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Free"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [view, label])
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
     
        stackView.translatesAutoresizingMaskIntoConstraints = false
       
        view.widthAnchor.constraint(equalToConstant: 11).isActive = true
        view.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        return stackView
    }()
    
    lazy var userStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [usedView, netflixView,freeView])
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    var usedBarView: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.usedBarBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userUnderLineView: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.underLineBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    func setupLayout(){
        addSubview(phoneName)
        addSubview(parentView)
        addSubview(userStackView)
        addSubview(usedBarView)
        addSubview(userUnderLineView)
        
        NSLayoutConstraint.activate([
            
            phoneName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            phoneName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            parentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            parentView.topAnchor.constraint(equalTo: phoneName.bottomAnchor, constant: 10),
            parentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            parentView.heightAnchor.constraint(equalToConstant: 10),
            
            userStackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            userStackView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
            userStackView.topAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 5),
            userStackView.heightAnchor.constraint(equalToConstant: 30),
            
            usedBarView.widthAnchor.constraint(equalToConstant: 115),
            usedBarView.heightAnchor.constraint(equalTo: parentView.heightAnchor),
            usedBarView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            usedBarView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            
            userUnderLineView.heightAnchor.constraint(equalToConstant: 1),
            userUnderLineView.topAnchor.constraint(equalTo: userStackView.bottomAnchor, constant: 0),
            userUnderLineView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            userUnderLineView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
