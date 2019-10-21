//
//  DownloadCell.swift
//  TableViews
//
//  Created by Mezut on 26/09/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class DownloadCell: UICollectionViewCell {
    
    var centerYConstraint: NSLayoutConstraint?
    var topConstraint: NSLayoutConstraint?
    
    
    var underlineView: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.underLineBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var settingLabel: UILabel = {
        let label = UILabel()
        label.text = "Wi-Fi Only"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var settingDescription: UILabel = {
        let label = UILabel()
        label.text = "Completed episodes will be deleted and replaced with the next episodes only on Wi-Fi"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.btnGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    var trashIcon: UIButton = {
       let button = UIButton(type: .system)
        button.isHidden = true
        button.setImage(#imageLiteral(resourceName: "trash-Icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let leftArrow: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "arrow-point-to-right").withRenderingMode(.alwaysOriginal), for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var switchIcon: UISwitch = {
        let slider = UISwitch()
        slider.isOn = true
        slider.onTintColor = Colors.switchColor
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(settingLabel)
        addSubview(settingDescription)
        addSubview(trashIcon)
        addSubview(switchIcon)
        addSubview(underlineView)
        addSubview(leftArrow)
        
        centerYConstraint = settingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        centerYConstraint?.isActive  = true
        
        topConstraint = settingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        topConstraint?.isActive = false
        
        NSLayoutConstraint.activate([
            settingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            settingDescription.topAnchor.constraint(equalTo: settingLabel.bottomAnchor, constant: 5),
            settingDescription.leadingAnchor.constraint(equalTo: settingLabel.leadingAnchor),
            settingDescription.trailingAnchor.constraint(equalTo: switchIcon.leadingAnchor, constant: -10),
            
            trashIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            trashIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            switchIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            switchIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            switchIcon.widthAnchor.constraint(equalToConstant: 51),
            
            leftArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            
            underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            underlineView.heightAnchor.constraint(equalToConstant: 1)
            
            
            ])
    }
    
   
}
