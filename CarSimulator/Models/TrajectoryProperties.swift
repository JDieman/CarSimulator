//
//  TrajectoryProperties.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import CoreGraphics

struct TrajectoryProperties {

    let angle: CGFloat
    let rotationRadius: CGFloat
    let radiusPosition: CGPoint
    let positionAfterRotation: CGPoint
    let destinationPosition: CGPoint
    
    var rotationDistance: CGFloat {
        return abs(angle * rotationRadius)
    }
    
    var movingDistance: CGFloat {
        return positionAfterRotation.getDistance(to: destinationPosition)
    }
    
    var distance: CGFloat {
        return rotationDistance + movingDistance
    }
    
}
