//
//  TransparentButton.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 20.12.2021.
//

import UIKit

// MARK: - AnimatedButton

class OpaqueOrNotButton: UIButton {
    override var isHighlighted: Bool {
            didSet {
                if isHighlighted {
                    self.alpha = 0.3
                } else {
                    self.alpha = 1
                }
            }
        }
}

