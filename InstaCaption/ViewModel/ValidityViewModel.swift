//
//  ButtonViewModel.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 19.12.2021.
//

import UIKit

protocol ValidityViewModel {
    var formIsValid: Bool {get}
    var buttonBackgroundColor: UIColor {get}
    var buttonTitleColor: UIColor {get}
}

protocol ValidityImageViewModel {
    var formIsValid: Bool {get}
    var imageViewBackgroundColor: UIColor {get}
}

struct ButtonViewModel: ValidityViewModel {
    
    init(image: UIImage) {
        self.image = image
    }
    
    var image: UIImage?
    
    var formIsValid: Bool {
        if image != nil {
            return true
        } else {
            return false
        }
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .systemPurple : .systemPurple.withAlphaComponent(0.4)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : .white.withAlphaComponent(0.67)
    }
}


struct ImageViewModel: ValidityImageViewModel {
    
    var formIsValid: Bool {
        if image != nil {
            return true
        } else {
            return false
        }
    }
    
    init(image: UIImage) {
        self.image = image
    }
    
    var image: UIImage?
    
    var imageViewBackgroundColor: UIColor {
        return formIsValid ? UIColor(white: 1, alpha: 0.15) : .clear
    }
}
