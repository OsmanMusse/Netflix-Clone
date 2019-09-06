//
//  extensions.swift
//  TableViews
//
//  Created by Mezut on 21/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit


extension UITextView {
    func centerTextVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
