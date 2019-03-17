//
//  CarLocationProperties.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import CoreGraphics

struct CarLocationProperties: LocationProperties {
    
    static var defaultLocation: LocationProperties {
        return CarLocationProperties(speed: 200, rotationRadius: 80, current: .zero, destination: .zero)
    }
    var speed: CGFloat //points per second
    var rotationRadius: CGFloat
    var current: Location
    var destination: Location
    
}
