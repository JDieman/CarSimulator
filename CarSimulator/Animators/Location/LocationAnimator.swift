//
//  LocationAnimator.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

protocol LocationAnimator {
    
    var animationInProgress: Bool { get }
    var locationProperties: LocationProperties { get set }
    func locate(_ view: UIView, to position: CGPoint, completion: (()->())?)
    func getDestinationAngle(for view: UIView, to position: CGPoint) -> CGFloat

}

extension LocationAnimator {
    
    var animationInProgress: Bool {
        return locationProperties.current != locationProperties.destination
    }
    
}
