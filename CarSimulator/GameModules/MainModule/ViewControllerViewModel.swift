//
//  ViewControllerViewModel.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 18/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import CoreGraphics

final class ViewControllerViewModel: TransportAnimationVCViewModel {

    lazy var transport: Transport = {
        let transportSize = CGSize(width: 20, height: 40)
        let transportPosition = CGPoint(x: delegate.center.x - transportSize.width/2, y: delegate.size.height - 200)
        return TransportFactory.getCar(frame: CGRect(origin: transportPosition, size: transportSize))
    }()
    
    private weak var delegate: TransportAnimationVCDelegate!
    
    init(delegate: TransportAnimationVCDelegate) {
        self.delegate = delegate
    }
    
    
    func onTap(_ location: CGPoint, completion: (() -> ())?) {
        transport.move(to: location, completion: completion)
    }
    
}
