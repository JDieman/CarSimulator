//
//  AnimatorsSegmentedControl.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

final class AnimatorsSegmentedControl: UISegmentedControl {
   
    override func awakeFromNib() {
        super.awakeFromNib()
        removeAllSegments()
        insertSegment(withTitle: "Без анимации", at: 0, animated: false)
        insertSegment(withTitle: "A", at: 1, animated: false)
        insertSegment(withTitle: "B", at: 2, animated: false)
        selectedSegmentIndex = 2
        backgroundColor = .white
    }
    
    func getCurrentAnimtor(for position: CGPoint) -> LocationAnimator {
        switch selectedSegmentIndex {
        case 0:
            return LocationAnimatorFactory.getSimpleAnimator(for: position)
        case 1:
            return LocationAnimatorFactory.getLinearAnimator(for: position)
        case 2:
            return LocationAnimatorFactory.getRealisticAnimator(for: position)
        default:
            return LocationAnimatorFactory.defaultAnimator
        }
    }
    
}
