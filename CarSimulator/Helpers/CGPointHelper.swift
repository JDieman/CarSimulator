//
//  CGPointHelper.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import CoreGraphics

extension CGPoint {
    
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    func getDistance(to point: CGPoint) -> CGFloat {
        return sqrt((point.y - self.y) * (point.y - self.y) + (point.x - self.x) * (point.x - self.x))
    }
    
}
