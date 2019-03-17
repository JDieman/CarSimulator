//
//  TransportAnimationVCDelegate.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 18/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import CoreGraphics

protocol TransportAnimationVCDelegate: AnyObject {
    var size: CGSize { get }
    var center: CGPoint { get }
}
