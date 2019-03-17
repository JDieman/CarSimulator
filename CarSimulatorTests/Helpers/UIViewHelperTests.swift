//
//  UIViewHelperTests.swift
//  CarSimulatorTests
//
//  Created by Dmitry Polyakov on 18/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import XCTest
@testable import CarSimulator

class UIViewHelperTests: XCTestCase {

    func testRotationAngle() {
        let angle: CGFloat = 3
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        view.transform = view.transform.rotated(by: angle)
        XCTAssertEqual(view.rotationAngle, angle)
    }

}
