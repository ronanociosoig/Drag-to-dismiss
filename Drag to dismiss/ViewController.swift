//
//  ViewController.swift
//  Drag to dismiss
//
//  Created by Dean Brindley on 27/11/2015.
//  Copyright © 2015 DeanBrindley. All rights reserved.
//

import UIKit

class ViewController: UIViewController, popupDelegate {
    
    var window: UIWindow?
    
    var topConstraint: NSLayoutConstraint?
    
    @IBAction func didTapButton() {
        
        window = UIWindow()
        
        guard let window = window else {
            return
        }
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("popupVC") as! popupVC
        
        vc.delegate = self
        
        window.rootViewController = vc
        window.backgroundColor = UIColor.clearColor()
        window.makeKeyAndVisible()
        
        addViewControllerToWindowConstraints(vc)
    }
    
    private func addViewControllerToWindowConstraints(vc: popupVC) {
        
        guard let window = window else {
            return
        }
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint = vc.view.topAnchor.constraintEqualToAnchor(window.topAnchor)
        let heightAnchor = vc.view.heightAnchor.constraintEqualToConstant(window.bounds.height)
        let leftAnchor = vc.view.leadingAnchor.constraintEqualToAnchor(window.leadingAnchor)
        let rightAnchor = vc.view.trailingAnchor.constraintEqualToAnchor(window.trailingAnchor)
        
        window.addConstraints([topConstraint!, heightAnchor!, leftAnchor!, rightAnchor!])
    }
    
    func didPan(y: CGFloat) {
        topConstraint?.constant = y
    }
    
    func dismissWindow(direction: dismissDirection) {
        
        switch direction {
        case .Bottom:
            self.topConstraint?.constant = self.view.bounds.height
        case .Top:
            self.topConstraint?.constant = -self.view.bounds.height
        }
        
        UIView.animateWithDuration(0.25, animations: {
            self.window?.layoutIfNeeded()
            }) { finished in
                self.window?.rootViewController = nil
                self.window = nil
                UIApplication.sharedApplication().windows.first?.makeKeyAndVisible()
        }
    }
    
    func resetWindow() {
        topConstraint?.constant = 0
        
        UIView.animateWithDuration(0.25) {
            self.window?.layoutIfNeeded()
        }
    }
    
}

