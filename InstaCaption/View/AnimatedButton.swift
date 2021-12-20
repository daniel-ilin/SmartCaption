//
//  HighlightedButton.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 20.12.2021.
//

import Foundation
import UIKit

class HighlightButton: UIButton {
    override var isHighlighted: Bool {
            didSet {
                
                animateButtonTapped(currentAnimation: .released)
                
                if isHighlighted {
                    self.alpha = 0.3
                } else {
                    self.alpha = 1
                }
            }
        }
}

extension UIView {
    
    func animateButtonTapped(currentAnimation: AnimationCase) {
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [],
                       animations: {
            switch currentAnimation {
            case .pushedDown:
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            case .released:
                self.transform = .identity
            }
        })
    }
}

