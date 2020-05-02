//
//  WarCustomCell.swift
//  TableViews
//
//  Created by Mezut on 13/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class WarFilmsCustomCell: BaseViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerLabel.text = "War Films"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
