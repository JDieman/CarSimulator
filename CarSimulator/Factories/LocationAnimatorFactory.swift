//
//  MoveAnimatorFactory.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 14/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import CoreGraphics

struct LocationAnimatorFactory {
    
    static var defaultAnimator: LocationAnimator {
        return BaseLocationAnimator(movebleProperties: CarLocationProperties.defaultLocation,
                                    rotationAnimator: SimpleRotationAnimator(),
                                    moveAnimator: LinearMovingAnimator())
    }
    
    static func getSimpleAnimator(for position: CGPoint) -> LocationAnimator {
        return BaseLocationAnimator(movebleProperties: getLocation(for: position),
                                    rotationAnimator: SimpleRotationAnimator(),
                                    moveAnimator: LinearMovingAnimator())
    }
    static func getLinearAnimator(for position: CGPoint) -> LocationAnimator {
        return LinearLocationAnimator(movebleProperties: getLocation(for: position),
                                      rotationAnimator: SimpleRotationAnimator(),
                                      moveAnimator: LinearMovingAnimator())
    }
    static func getRealisticAnimator(for position: CGPoint) -> LocationAnimator {
        return RealisticLocationAnimator(movebleProperties: getLocation(for: position),
                                         rotationAnimator: HardRotationAnimator(),
                                         moveAnimator: LinearMovingAnimator())
    }
    
    
    private static func getLocation(for position: CGPoint) -> LocationProperties {
        var location = CarLocationProperties.defaultLocation
        location.current.position = position
        location.destination.position = position
        return location
    }
    
}
