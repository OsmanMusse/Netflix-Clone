//
//  InnerDownloadHeader.swift
//  TableViews
//
//  Created by Mezut on 21/01/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class InnerDownloadHeader: UICollectionViewCell {
    
    let padding: CGFloat = 8
    
    let downloadHeaderTitle: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.settingBg
        setupLayout()
    }
    
    
    func setupLayout(){
      addSubview(downloadHeaderTitle)
        
        NSLayoutConstraint.activate([
            
            downloadHeaderTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:padding),
            downloadHeaderTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            downloadHeaderTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
