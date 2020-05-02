//
//  SignOutCell.swift
//  TableViews
//
//  Created by Mezut on 06/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class SignOutCell: UICollectionViewCell {
    
    var settingController: SettingScreenController?
    
    lazy var signOutBtn: UIButton = {
       let button = UIButton(type: .custom)
        button.setTitle("Sign Out", for: .normal)
        button.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        button.setTitleColor(UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let appVersionLabel: UILabel = {
       let label = UILabel()
        label.text = "Version: 12.23.0 (3020)"
        label.textColor = Colors.btnLightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [signOutBtn, appVersionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = -10
        stack.alignment = .center
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @objc func handleSignOut(){
        self.settingController?.showAlertController()
    }
    
    func setupLayout(){
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            stackView.heightAnchor.constraint(equalToConstant: 65),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
