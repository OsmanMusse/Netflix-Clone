//
//  NetworkAlertView.swift
//  TableViews
//
//  Created by Mezut on 10/05/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Network
import Reachability

class NetworkAlertView: UIView {
    
    let networkMessageLabel: UILabel = {
       let label = UILabel()
        label.text = "No Internet Connection"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var monitor = NWPathMonitor()
    
    let reachability = try! Reachability()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupNetworkReachability()
        setupLayout()
        
    }
    
    func setupNetworkReachability(){

    }
    
    func setupLayout(){
        addSubview(networkMessageLabel)
        
        NSLayoutConstraint.activate([
            networkMessageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            networkMessageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
