//
//  MailLikeDismisser.swift
//  Pods
//
//  Created by Nick Kibish on 9/2/16.
//
//

import UIKit
private let viewTag = 101

public class MailLikeDismisser: NSObject {
    var animationDuration: NSTimeInterval = 0.5
    var topMargin: CGFloat = 50
    var presentingVCAlpha: CGFloat = 0.7
    var scale: CGFloat = 0.9
}

extension MailLikeDismisser: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let containerView = transitionContext.containerView(),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
        }
        
        var toSnapshot = toVC.view.snapshotViewAfterScreenUpdates(true)
        if let v = containerView.viewWithTag(viewTag) {
            toSnapshot = v
        }
        toVC.view.removeFromSuperview()
        
        let fromSnapshot = fromVC.view.snapshotViewAfterScreenUpdates(true)
        fromSnapshot.frame = fromVC.view.frame
        fromVC.view.removeFromSuperview()
        
        containerView.addSubview(toSnapshot)
        containerView.addSubview(fromSnapshot)
        
        toVC.view.alpha = 1
        toVC.view.transform = CGAffineTransformMakeScale(1, 1)
        toVC.view.hidden = true
        
        let duration = transitionDuration(transitionContext)
        
        var finishedFrame = fromSnapshot.frame
        finishedFrame.origin.y += finishedFrame.height
        
        UIView.animateWithDuration(duration, animations: {
            fromSnapshot.frame = finishedFrame
            toSnapshot.alpha = 1
            toSnapshot.transform = CGAffineTransformMakeScale(1, 1)
            
        }) { (finished) in
            fromSnapshot.removeFromSuperview()
            toSnapshot.removeFromSuperview()
            toVC.view.hidden = false
            
            transitionContext.completeTransition(finished)
        }
    }
}