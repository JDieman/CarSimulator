//
//  MovingAnimator.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

protocol MovingAnimator {
    func move(_ view: UIView, to position: CGPoint, with duration: TimeInterval, and options: UIView.AnimationOptions, completion: ((Bool)->())?)
}
