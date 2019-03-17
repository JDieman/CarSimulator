//
//  LinearLocationAnimator.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

class LinearLocationAnimator: BaseLocationAnimator {
    
    override func locate(_ view: UIView, to position: CGPoint, completion: (()->())?) {
        guard view.presentationCenter != position else { return }
        self.completion = completion
        if animationInProgress {
            stop(view)
        }
        locate(view, to: position, with: 0.5, completion: completion)
    }
    
    func stop(_ view: UIView) {
        let presentationPlace = Location(position: view.presentationCenter, angle: view.presentationRotationAngle)
        view.layer.removeAllAnimations()
        let currentAngle = atan2(view.transform.b, view.transform.a)
        let newAngle = presentationPlace.angle - currentAngle
        let lastplace = Location(position: presentationPlace.position, angle: newAngle)
        view.transform = view.transform.rotated(by: lastplace.angle)
        view.center = lastplace.position
        locationProperties.destination = lastplace
    }
    
}
