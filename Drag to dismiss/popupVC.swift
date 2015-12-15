//
//  popupVC.swift
//  Drag to dismiss
//
//  Created by Dean Brindley on 27/11/2015.
//  Copyright © 2015 DeanBrindley. All rights reserved.
//

import UIKit

enum dismissDirection {
    case Top
    case Bottom
}

protocol popupDelegate {
    func didPan(y: CGFloat)
    func dismissWindow(direction: dismissDirection)
    func resetWindow()
}

class popupVC: UIViewController, UIGestureRecognizerDelegate {
    
    var delegate: popupDelegate?
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let yMovement = sender.translationInView(self.view).y
        
        delegate?.didPan(yMovement)
        
        if sender.state == UIGestureRecognizerState.Ended {
            let velocity = sender.velocityInView(self.view)
            
            if velocity.y > 100 {
                delegate?.dismissWindow(.Bottom)
            } else if velocity.y < -100 {
                delegate?.dismissWindow(.Top)
            } else {
                delegate?.resetWindow()
            }
        }
    }

}
