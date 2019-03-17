//
//  TransportAnimationViewModel.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 18/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import CoreGraphics

protocol TransportAnimationVCViewModel {
    var transport: Transport { get }
    func onTap(_ location: CGPoint, completion: (()->())?)
}
