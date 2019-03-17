//
//  CGPointHelperTests.swift
//  CarSimulatorTests
//
//  Created by Dmitry Polyakov on 18/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import XCTest
@testable import CarSimulator

class CGPointHelperTests: XCTestCase {

    private var pointA: CGPoint!
    private var pointB: CGPoint!
    
    override func setUp() {
        pointA = CGPoint(x: 10, y: 50)
        pointB = CGPoint(x: 40, y: 10)
    }
    
    func testOperatorMinus() {
        XCTAssertEqual(pointB - pointA, CGPoint(x: 30, y: -40))
        XCTAssertEqual(pointA - pointB, CGPoint(x: -30, y: 40))
    }

    func testDistance() {
        XCTAssertEqual(pointA.getDistance(to: pointB), 50)
        XCTAssertEqual(pointB.getDistance(to: pointA), 50)
        XCTAssertGreaterThanOrEqual(pointA.getDistance(to: pointB), 0)
    }

}
