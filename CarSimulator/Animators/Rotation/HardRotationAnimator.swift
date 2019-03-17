//
//  HardRotationAnimator.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

final class HardRotationAnimator: RotationAnimator {
    
    func rotate(_ view: UIView, by angle: CGFloat, with duration: TimeInterval, and options: UIView.AnimationOptions, completion: ((Bool)->())?) {
        var angle = angle
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            if abs(angle) > CGFloat.pi {
                angle /= 2
                view.transform = view.transform.rotated(by: angle)
            }
            view.transform = view.transform.rotated(by: angle)
        }, completion: completion)
    }

}
