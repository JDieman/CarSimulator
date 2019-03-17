//
//  UIViewHelper.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 14/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

extension UIView {
    
    var presentationCenter: CGPoint {
        return layer.presentation()!.center
    }
    
    var presentationRotationAngle: CGFloat {
        return layer.presentation()!.rotationAngle
    }
    
    var rotationAngle: CGFloat {
        return atan2(transform.b, transform.a)
    }
    
}
