//
//  CALayerHelperTests.swift
//  CarSimulatorTests
//
//  Created by Dmitry Polyakov on 18/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import XCTest
@testable import CarSimulator

class CALayerHelperTests: XCTestCase {

    func testCenter() {
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        XCTAssertEqual(view.layer.center, CGPoint(x: 15, y: 15))
    }

    func testRotationAngle() {
        let angle: CGFloat = 2
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        view.transform = view.transform.rotated(by: angle)
        XCTAssertEqual(view.layer.rotationAngle, angle)
    }

}
