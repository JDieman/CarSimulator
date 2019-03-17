//
//  CALayerHelper.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 14/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import QuartzCore

extension CALayer {
    
    var center: CGPoint {
        return CGPoint(x: frame.origin.x + frame.width/2, y: frame.origin.y + frame.height/2)
    }
    
    var rotationAngle: CGFloat {
        return atan2(transform.m12, transform.m11)
    }
}
