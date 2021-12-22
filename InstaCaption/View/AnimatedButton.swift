//
//  HighlightedButton.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 20.12.2021.
//

import UIKit

// MARK: - AnimatedButton

class AnimatedButton: UIButton {
    override var isHighlighted: Bool {
            didSet {
                if isHighlighted {
                    animateButtonTapped(currentAnimation: .pushedDown)
                    self.alpha = 0.3
                } else {
                    animateButtonTapped(currentAnimation: .released)
                    self.alpha = 1
                }
            }
        }
}

// MARK: - AnimateButtonTapped

extension AnimatedButton {
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

