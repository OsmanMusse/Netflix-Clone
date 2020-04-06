//
//  InnerSettingCell.swift
//  TableViews
//
//  Created by Mezut on 06/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class InnerSettingCell: UICollectionViewCell {
    
    private let padding: CGFloat = 15
    
    let parentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var settingIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var settingLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var rightLabelIcon: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "arrow-down-sign-to-navigate-1").withRenderingMode(.alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var underlineView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupLayout()
        
    }
    
    func setupLayout(){
        addSubview(underlineView)
        addSubview(parentView)
        parentView.addSubview(settingIcon)
        parentView.addSubview(settingLabel)
        parentView.addSubview(rightLabelIcon)
       
        
        NSLayoutConstraint.activate([
            
            underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            underlineView.widthAnchor.constraint(equalToConstant: self.frame.width),
            underlineView.heightAnchor.constraint(equalToConstant: 1.8),
            
            parentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            parentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            parentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            parentView.topAnchor.constraint(equalTo: self.topAnchor),
            
            settingIcon.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            settingIcon.centerYAnchor.constraint(equalTo: self.parentView.centerYAnchor),
            
            settingLabel.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            settingLabel.leadingAnchor.constraint(equalTo: settingIcon.trailingAnchor, constant: 10),
            
            rightLabelIcon.centerYAnchor.constraint(equalTo: self.parentView.centerYAnchor),
            rightLabelIcon.trailingAnchor.constraint(equalTo: self.parentView.trailingAnchor),
            

            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
