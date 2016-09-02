//
//  ViewController.swift
//  MailLikeAnimator
//
//  Created by Nick Kibish on 09/02/2016.
//  Copyright (c) 2016 Nick Kibish. All rights reserved.
//

import UIKit
import MailLikeAnimator

class ViewController: UIViewController {
    var presenter = MailLikePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController.transitioningDelegate = self 
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presenter
    }
}