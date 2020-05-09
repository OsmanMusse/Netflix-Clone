//
//  EpisodeHeader.swift
//  TableViews
//
//  Created by Mezut on 22/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class EpisodeHeader: UICollectionViewCell {
    
    var singleVideoReference: SingleVideoController?
    
    
    let padding: CGFloat = 8
    
    lazy var overlayAnimationView: UIView = {
        let view = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleModalExit))
        view.addGestureRecognizer(tap)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let seasonLabel:UILabel = {
        let label = UILabel()
        label.text = "Season 1"
        label.textColor = Colors.lightGray
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
        addSubview(seasonLabel)
        addSubview(overlayAnimationView)
        
        
        NSLayoutConstraint.activate([
            
            seasonLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            seasonLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            
            overlayAnimationView.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            overlayAnimationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            overlayAnimationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            overlayAnimationView.heightAnchor.constraint(equalToConstant: 800),
            
            
            ])
    }
    
    @objc func handleModalExit(){
        let notification = Notification(name: NotificationName.OverlayViewDidTap.name)
        NotificationCenter.default.post(notification)
    }
    
    
    
}



class CustomVideoCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


