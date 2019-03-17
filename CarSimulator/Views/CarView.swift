//
//  CarView.swift
//  CarTest
//
//  Created by Dmitry Polyakov on 13/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

final class CarView: UIView {
    
    var locationAnimator: LocationAnimator
    private lazy var headView = HeadView(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                       size: CGSize(width: frame.size.width, height: frame.size.height/3)))
    private lazy var checkersView = CheckersView(frame: CGRect(origin: CGPoint(x: 2, y: frame.height/2),
                                                                 size: CGSize(width: frame.width - 4, height: (frame.width - 4)/2)))
    init(frame: CGRect, locationAnimator: LocationAnimator) {
        self.locationAnimator = locationAnimator
        super.init(frame: frame)
        backgroundColor = .orange
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        addSubview(headView)
        addSubview(checkersView)
        addWheels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        locationAnimator = LocationAnimatorFactory.defaultAnimator
        super.init(coder: aDecoder)
    }
    
    private func addWheels() {
        for index in 0..<4 {
            let wheel = WheelView(frame: CGRect(origin: CGPoint(x: index % 2 == 0 ? -1 : frame.width,
                                                                y: index < 2 ? frame.height/6 : frame.height - frame.height/5 - 3 ),
                                                size: CGSize(width: 1, height: 6)))
            addSubview(wheel)
        }
    }
}

extension CarView: Transport {
    
    var view: UIView {
        return self
    }
    
    func move(to position: CGPoint, completion: (()->())?) {
        locationAnimator.locate(self, to: position, completion: completion)
    }

}
