//
//  CheckersView.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

final class CheckersView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let size = frame.width/4
        for index in 0..<4 {
            let checker = UIView(frame: CGRect(origin: CGPoint(x: CGFloat(index) * size,
                                                               y: index % 2 == 0 ? CGFloat(0) : CGFloat(size)),
                                               size: CGSize(width: size, height: size)))
            checker.backgroundColor = .black
            addSubview(checker)
        }
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
