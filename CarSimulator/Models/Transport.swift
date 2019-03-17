//
//  Car.swift
//  CarTest
//
//  Created by Dmitry Polyakov on 13/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

protocol Transport: AnyObject {
    
    var view: UIView { get }
    var locationAnimator: LocationAnimator { get set }
    func move(to position: CGPoint, completion: (()->())?)

}
