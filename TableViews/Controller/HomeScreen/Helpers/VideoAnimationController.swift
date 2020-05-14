//
//  VideoAnimationController.swift
//  TableViews
//
//  Created by Mezut on 02/05/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit



class VideoAnimationController: NSObject {
    
    private let animationDuraion: Double
    private let animationType: AnimationType
    
    enum AnimationType {
        case present
        case dismiss
    }
    
    
    init(animationDuration: Double, animationType: AnimationType) {
        self.animationDuraion = animationDuration
        self.animationType = animationType
    }
}

extension VideoAnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuraion) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController =  transitionContext.viewController(forKey: .to) else {return}
        
        switch animationType {
        case .present:
            transitionContext.containerView.addSubview(toViewController.view)
        presentAnimation(with: transitionContext, viewToAnimate: toViewController.view)
        case .dismiss: return
        }
    }
    
    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView){

        if let keyWindow = UIApplication.shared.keyWindow {
            viewToAnimate.frame = CGRect(x: keyWindow.frame.width, y: keyWindow.frame.height
                , width: 30, height: 30)
            
           let duration = transitionDuration(using: transitionContext)
            
            UIView.animate(withDuration: duration, animations: {
                viewToAnimate.frame = keyWindow.frame
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
        
        
    }
    
    
}

