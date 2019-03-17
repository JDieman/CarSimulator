//
//  LocationProperties.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import CoreGraphics

protocol LocationProperties {
    
    static var defaultLocation: LocationProperties { get }
    var speed: CGFloat { get }
    var rotationRadius: CGFloat { get set }
    var current: Location { get set }
    var destination: Location { get set }

}
