//
//  BaseLocationAnimator.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

class BaseLocationAnimator: LocationAnimator {
    
    var rotationAnimator: RotationAnimator
    var moveAnimator: MovingAnimator
    var locationProperties: LocationProperties
    var completion: (()->())?
    
    init(movebleProperties: LocationProperties, rotationAnimator: RotationAnimator, moveAnimator: MovingAnimator) {
        self.locationProperties = movebleProperties
        self.rotationAnimator = rotationAnimator
        self.moveAnimator = moveAnimator
    }
    
    func locate(_ view: UIView, to position: CGPoint, completion: (()->())?) {
        guard view.center != position else { return }
        self.completion = completion
        completion?()
        locate(view, to: position, with: 0, completion: completion)
    }
    
    func locate(_ view: UIView, to position: CGPoint, with duration: TimeInterval, completion: (()->())?) {
        let angle = getDestinationAngle(for: view, to: position)
        locationProperties.destination = Location(position: position, angle: angle)
        rotationAnimator.rotate(view, by: angle, with: duration, and: .curveEaseInOut, completion: {
            [weak self]
            successed in
            guard successed else { return }
            self?.moveAnimator.move(view, to: position, with: duration, and: .curveEaseInOut, completion: self?.locationComplete)
        })
    }
    
    func locationComplete(_ successed: Bool) {
        guard successed else { return }
        locationProperties.current = locationProperties.destination
        completion?()
    }
    
    func getDestinationAngle(for view: UIView, to position: CGPoint) -> CGFloat {
        let angelCorrector: CGFloat = (position.y - view.center.y) < 0 ? 0 : CGFloat.pi
        let newAngle = angelCorrector - atan((position.x - view.center.x)/(position.y - view.center.y))
        return newAngle - view.rotationAngle
    }
    
}
