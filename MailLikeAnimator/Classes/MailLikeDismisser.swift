//
//  MailLikeDismisser.swift
//  Pods
//
//  Created by Nick Kibish on 9/2/16.
//
//

import UIKit
private let viewTag = 101

open class MailLikeDismisser: NSObject {
    var animationDuration: TimeInterval = 0.5
    var topMargin: CGFloat = 50
    var presentingVCAlpha: CGFloat = 0.7
    var scale: CGFloat = 0.9
}

extension MailLikeDismisser: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        
        let containerView = transitionContext.containerView
        
        var toSnapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        if let v = containerView.viewWithTag(viewTag) {
            toSnapshot = v
        }
        toVC.view.removeFromSuperview()
        
        let fromSnapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
        fromSnapshot?.frame = fromVC.view.frame
        fromVC.view.removeFromSuperview()
        
        if let toSnapshot = toSnapshot {
            containerView.addSubview(toSnapshot)
        }
        if let fromSnapshot = fromSnapshot {
            containerView.addSubview(fromSnapshot)
        }
        
        toVC.view.alpha = 1
        toVC.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        var finishedFrame = fromSnapshot?.frame
        finishedFrame?.origin.y += (finishedFrame?.height)!
        
        UIView.animate(withDuration: duration, animations: {
            fromSnapshot?.frame = finishedFrame!
            toSnapshot?.alpha = 1
            toSnapshot?.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }, completion: { (finished) in
            fromSnapshot?.removeFromSuperview()
            toSnapshot?.removeFromSuperview()
            toVC.view.isHidden = false
            
            transitionContext.completeTransition(finished)
        }) 
    }
}
