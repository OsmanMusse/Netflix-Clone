//
//  VideoAnimationController.swift
//  TableViews
//
//  Created by Mezut on 02/05/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class VideoAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if let time = TimeInterval(exactly: 1.0) {
            return time
        }
        return TimeInterval(exactly: 1.02)!
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    
}
