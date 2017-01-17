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
    var animationDuration: TimeInterval = 0.5
    var topMargin: CGFloat = 50
    var presentingVCAlpha: CGFloat = 0.7
    var scale: CGFloat = 0.9
}

extension MailLikePresenter: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        var initialFrame = UIScreen.main.bounds
        initialFrame.size.height -= topMargin
        initialFrame.origin.y = initialFrame.height
        
        var finalFrame = initialFrame
        finalFrame.origin.y = topMargin
        
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = initialFrame
        
        let fromSnapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        fromSnapshot?.transform = CGAffineTransform(scaleX: scale, y: scale)
        fromSnapshot?.alpha = presentingVCAlpha
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let alpha = self?.presentingVCAlpha,
            let scale = self?.scale else {
                return
            }
            
            snapshot?.frame = finalFrame
            fromVC.view.transform = CGAffineTransform(scaleX: scale, y: scale)
            fromVC.view.alpha = alpha
            
        }) { (completed) in
            fromSnapshot?.tag = viewTag
            containerView.insertSubview(fromSnapshot!, at: 0)
            snapshot?.removeFromSuperview()
            toVC.view.frame = finalFrame
            toVC.view.isHidden = false
            
            transitionContext.completeTransition(completed)
        }
    }
}
