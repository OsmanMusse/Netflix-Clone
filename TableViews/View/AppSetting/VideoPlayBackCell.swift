//
//  AppSettingCell.swift
//  TableViews
//
//  Created by Mezut on 26/09/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit


class VideoPlayBackCell: UICollectionViewCell {
    
    let MobileDataLabel: UIButton = {
      let button = UIButton(type: .system)
        button.setTitle("Mobile Data Usage", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dataUsageType: UILabel = {
       let label = UILabel()
        label.text = "Automatic"
        label.textColor = Colors.btnGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftArrow: UIButton = {
       let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "arrow-point-to-right").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(MobileDataLabel)
        addSubview(dataUsageType)
        addSubview(leftArrow)
        
        
        NSLayoutConstraint.activate([
            
            MobileDataLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
             MobileDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
             
             dataUsageType.topAnchor.constraint(equalTo: MobileDataLabel.bottomAnchor, constant: 2),
             dataUsageType.leadingAnchor.constraint(equalTo: MobileDataLabel.leadingAnchor),
             
             leftArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor),
             leftArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
            
            ])
    }
    
    
}
