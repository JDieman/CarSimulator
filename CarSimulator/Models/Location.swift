//
//  Location.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import CoreGraphics

struct Location: Equatable {
    
    static var zero: Location {
        return Location(position: .zero, angle: 0)
    }
    
    var position: CGPoint
    var angle: CGFloat
    
}
