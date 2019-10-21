//
//  AppSettingHeader.swift
//  TableViews
//
//  Created by Mezut on 26/09/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class AppSettingHeader: UICollectionViewCell {
    
    let underlineView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerLabel: UILabel = {
      let label = UILabel()
        label.text = "Video Playback".uppercased()
        label.textColor = Colors.btnGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(headerLabel)
        addSubview(underlineView)
        
        NSLayoutConstraint.activate([
            
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 7),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            underlineView.topAnchor.constraint(equalTo: self.bottomAnchor),
            underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underlineView.widthAnchor.constraint(equalToConstant: self.frame.width),
            underlineView.heightAnchor.constraint(equalToConstant: 1)
            
            ])
    }
    
    
}
