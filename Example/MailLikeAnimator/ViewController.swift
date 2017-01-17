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
    var dismisser = MailLikeDismisser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self 
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presenter
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismisser
    }
}
