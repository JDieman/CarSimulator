//
//  TransportFactory.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 14/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import CoreGraphics

struct TransportFactory {
    
    static func getCar(frame: CGRect) -> Transport {
        return CarView(frame: frame, locationAnimator: LocationAnimatorFactory.getRealisticAnimator(for: frame.origin))
    }
    
}
