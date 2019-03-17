//
//  RealisticLocationAnimator.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 17/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

final class RealisticLocationAnimator: LinearLocationAnimator {
    
    override func locate(_ view: UIView, to position: CGPoint, completion: (() -> ())?) {
        guard view.presentationCenter != position else { return }
        self.completion = completion
        var rotationAnimation = UIView.AnimationOptions.curveEaseIn
        if animationInProgress {
            stop(view)
            rotationAnimation = .curveLinear
        }
        let trajectoryProperties = getTheBestTraectoryProperties(view, to: position, with: locationProperties)
        view.layer.anchorPoint = getAnchorPoint(for: view.bounds.size, and: trajectoryProperties.rotationRadius)
        view.center = trajectoryProperties.radiusPosition
        locationProperties.destination = Location(position: position, angle: trajectoryProperties.angle)
        rotationAnimator.rotate(view, by: trajectoryProperties.angle, with: TimeInterval(trajectoryProperties.rotationDistance/locationProperties.speed), and: rotationAnimation, completion: {
            [weak self]
            successed in
            guard successed, let `self` = self else { return }
            view.layer.anchorPoint = self.getAnchorPoint(for: view.frame.size, and: 0)
            view.center = self.getCorrectedViewCenter(currentPosition: view.center,
                                                      rotationRadius: trajectoryProperties.rotationRadius,
                                                      rotationAngle: view.presentationRotationAngle)
            let distance = view.center.getDistance(to: position)
            self.moveAnimator.move(view,
                                   to: position,
                                   with: TimeInterval(abs(distance/self.locationProperties.speed)),
                                   and: .curveEaseOut,
                                   completion: self.locationComplete)
        })
    }
    
    private func getAnchorPoint(for size: CGSize, and rotationRadius: CGFloat) -> CGPoint {
        return CGPoint(x: 0.5 + rotationRadius/size.width, y: 0.5)
    }
    
    private func getCorrectedViewCenter(currentPosition: CGPoint, rotationRadius: CGFloat, rotationAngle: CGFloat) -> CGPoint {
        let x = currentPosition.x - rotationRadius * cos(rotationAngle)
        let y = currentPosition.y - rotationRadius * sin(rotationAngle)
        return CGPoint(x: x, y: y)
    }
    
    private func getApproximateAngleAndPositionOnCircle(_ view: UIView, to position: CGPoint, with locationProperties: LocationProperties, radiusPos: CGPoint, direction: RotationDirection, destinationInRadius: Bool) -> (angle: CGFloat, positionAfterRotation: CGPoint) {
        let startAngle = getDestinationAngle(from: view.presentationCenter,
                                             with: view.presentationRotationAngle,
                                             to: position,
                                             direction: direction,
                                             destinationInRadius: destinationInRadius)
        var positionAfterRotation = getPositionOnCircle(
            startAngle: startAngle,
            currentPosition: view.presentationCenter,
            radiusPosition: radiusPos)
        var angle = getDestinationAngle(from: positionAfterRotation, with: view.presentationRotationAngle, to: position, direction: direction, destinationInRadius: destinationInRadius)
        positionAfterRotation = getPositionOnCircle(
            startAngle: angle,
            currentPosition: view.presentationCenter,
            radiusPosition: radiusPos)
        angle = getDestinationAngle(from: positionAfterRotation, with: view.presentationRotationAngle, to: position, direction: direction, destinationInRadius: destinationInRadius)
        positionAfterRotation = getPositionOnCircle(
            startAngle: angle,
            currentPosition: view.presentationCenter,
            radiusPosition: radiusPos)
        return (angle, positionAfterRotation)
    }
    
    private func calculateApproximateAngleAndPositionOnCircle(from approxPosition: CGPoint, to position: CGPoint, radiusPos: CGPoint, direction: RotationDirection, destinationInRadius: Bool, in view: UIView) -> (angle: CGFloat, positionAfterRotation: CGPoint) {
        let angle = getDestinationAngle(from: approxPosition,
                                        with: view.presentationRotationAngle,
                                        to: position,
                                        direction: direction,
                                        destinationInRadius: destinationInRadius)
        return (angle:angle,
                positionAfterRotation: getPositionOnCircle(startAngle: angle,
                                                           currentPosition: view.presentationCenter,
                                                           radiusPosition: radiusPos))
    }
    
    private func getDestinationInRadius(radiusPosRight: CGPoint, radiusPosLeft: CGPoint, rotationRadius: CGFloat, finalPosition: CGPoint) -> Bool {
        let distanceFromRadiusRight = radiusPosRight.getDistance(to: finalPosition)
        let distanceFromRadiusLeft = radiusPosLeft.getDistance(to: finalPosition)
        return abs(distanceFromRadiusRight) < rotationRadius || abs(distanceFromRadiusLeft) < rotationRadius
    }
    
    private func getTraectoryProperties(_ view: UIView, to position: CGPoint, with locationProperties: LocationProperties, for direction: RotationDirection, radiusPos: CGPoint, destinationInRadius: Bool) -> TrajectoryProperties {
        let (angle, positionAfterRotation) = getApproximateAngleAndPositionOnCircle(view,
                                                                                    to: position,
                                                                                    with: locationProperties,
                                                                                    radiusPos: radiusPos,
                                                                                    direction: direction,
                                                                                    destinationInRadius: destinationInRadius)
        return TrajectoryProperties(angle: angle,
                                    rotationRadius: direction == .right ? locationProperties.rotationRadius : -locationProperties.rotationRadius,
                                    radiusPosition: radiusPos,
                                    positionAfterRotation: positionAfterRotation,
                                    destinationPosition: position)
    }
    
    private func getTheBestTraectoryProperties(_ view: UIView, to position: CGPoint, with locationProperties: LocationProperties) -> TrajectoryProperties {
        let radiusPosRight = getRadiusPosition(presentationAngle: view.presentationRotationAngle,
                                               currentPosition: view.center,
                                               rotationRadius: locationProperties.rotationRadius)
        let radiusPosLeft = getRadiusPosition(presentationAngle: view.presentationRotationAngle,
                                              currentPosition: view.center,
                                              rotationRadius: -locationProperties.rotationRadius)
        let destinationInRadius = getDestinationInRadius(radiusPosRight: radiusPosRight,
                                                         radiusPosLeft: radiusPosLeft,
                                                         rotationRadius: locationProperties.rotationRadius,
                                                         finalPosition: position)
        let trajectoryPropertiesRight = getTraectoryProperties(view, to: position, with: locationProperties, for: .right, radiusPos: radiusPosRight, destinationInRadius: destinationInRadius)
        let trajectoryPropertiesLeft = getTraectoryProperties(view, to: position, with: locationProperties, for: .left, radiusPos: radiusPosLeft, destinationInRadius: destinationInRadius)
        let direction = getDirection(tPRight: trajectoryPropertiesRight, tPLeft: trajectoryPropertiesLeft, for: destinationInRadius)
        switch direction {
        case .right:
            return trajectoryPropertiesRight
        case .left:
            return trajectoryPropertiesLeft
        }
    }
    
    private func getDirection(tPRight: TrajectoryProperties, tPLeft: TrajectoryProperties, for destinationInRadius: Bool) -> RotationDirection {
        if destinationInRadius {
            return tPRight.rotationDistance > tPLeft.rotationDistance ? .right : .left
        } else {
            return tPRight.distance < tPLeft.distance ? .right : .left
        }
    }
    
    private func getRadiusPosition(presentationAngle: CGFloat, currentPosition: CGPoint, rotationRadius: CGFloat) -> CGPoint {
        let cosA = cos(presentationAngle)
        let sinA = sin(presentationAngle)
        let rx = currentPosition.x + rotationRadius * cosA
        let ry = currentPosition.y + rotationRadius * sinA
        return CGPoint(x: rx, y: ry)
    }
    
    private func getPositionOnCircle(startAngle: CGFloat, currentPosition: CGPoint, radiusPosition: CGPoint) -> CGPoint {
        let ax = currentPosition.x - radiusPosition.x
        let ay = currentPosition.y - radiusPosition.y
        let cosB = cos(startAngle)
        let sinB = sin(startAngle)
        let x = radiusPosition.x + ax * cosB - ay * sinB
        let y = radiusPosition.y + ax * sinB + ay * cosB
        return CGPoint(x: x, y: y)
    }
    
    private func getDestinationAngle(from position: CGPoint, with currentAngle: CGFloat, to newPosition: CGPoint, direction: RotationDirection, destinationInRadius: Bool) -> CGFloat {
        let quarter = getQuarter(from: position, and: newPosition)
        // Correction for making left direction on the left of car and right direction on the right of car
        let yCorrector: CGFloat = (newPosition.y - position.y) < 0 ? -1 : 1
        var newAngle = yCorrector * atan((newPosition.x - position.x)/(newPosition.y - position.y))
        switch quarter {
        case 3:
            newAngle = -CGFloat.pi - newAngle
        case 4:
            newAngle = CGFloat.pi - newAngle
        default:
            break
        }
        let rightAngle = newAngle - currentAngle
        let leftAngle = -((rightAngle > 0 ? 1 : -1) * 2 * CGFloat.pi - rightAngle)
        switch direction {
        case .right:
            return leftAngle < 0 ? rightAngle : leftAngle
        case .left:
            return rightAngle < 0 ? rightAngle : leftAngle
        }
    }
    
    private func getQuarter(from position: CGPoint, and newPosition: CGPoint) -> Int {
        let distances = newPosition - position
        switch (distances.x, distances.y) {
        case (...0, ...0):
            return 2
        case (...0, 0...):
            return 3
        case (0..., ...0):
            return 1
        case (0..., 0...):
            return 4
        default:
            return 2
        }
    }
    
}
