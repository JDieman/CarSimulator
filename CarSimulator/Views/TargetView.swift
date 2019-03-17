//
//  TargetView.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

final class TargetView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        layer.cornerRadius = 5
        backgroundColor = .orange
        isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
