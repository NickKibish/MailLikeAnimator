//
//  MailLikePresenter.swift
//  Pods
//
//  Created by Nick Kibish on 9/2/16.
//
//

import UIKit
private let viewTag = 101

public class MailLikePresenter: NSObject {
    var animationDuration: NSTimeInterval = 0.5
    var topMargin: CGFloat = 50
    var presentingVCAlpha: CGFloat = 0.7
    var scale: CGFloat = 0.9
}

extension MailLikePresenter: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
        let containerView = transitionContext.containerView(),
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        var initialFrame = UIScreen.mainScreen().bounds
        initialFrame.size.height -= topMargin
        initialFrame.origin.y = initialFrame.height
        
        var finalFrame = initialFrame
        finalFrame.origin.y = topMargin
        
        let snapshot = toVC.view.snapshotViewAfterScreenUpdates(true)
        snapshot.frame = initialFrame
        
        let fromSnapshot = fromVC.view.snapshotViewAfterScreenUpdates(true)
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.hidden = true
        
        let duration = transitionDuration(transitionContext)
        
        fromSnapshot.transform = CGAffineTransformMakeScale(scale, scale)
        fromSnapshot.alpha = presentingVCAlpha
        
        UIView.animateWithDuration(duration, animations: { [weak self] in
            guard let alpha = self?.presentingVCAlpha,
            let scale = self?.scale else {
                return
            }
            
            snapshot.frame = finalFrame
            fromVC.view.transform = CGAffineTransformMakeScale(scale, scale)
            fromVC.view.alpha = alpha
            
        }) { (completed) in
            fromSnapshot.tag = viewTag
            containerView.insertSubview(fromSnapshot, atIndex: 0)
            snapshot.removeFromSuperview()
            toVC.view.frame = finalFrame
            toVC.view.hidden = false
            
            transitionContext.completeTransition(completed)
        }
    }
}