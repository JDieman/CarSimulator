//
//  ViewController.swift
//  CarSimulator
//
//  Created by Dmitry Polyakov on 13/03/2019.
//  Copyright © 2019 Dmitry Polyakov. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    private var viewModel: TransportAnimationVCViewModel!
    private let target = TargetView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    @IBOutlet private var segmentedControl: AnimatorsSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewControllerViewModel(delegate: self)
        view.addSubview(target)
        view.addSubview(viewModel.transport.view)
        
        let tapGesterRecogniser = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesterRecogniser)
        view.bringSubviewToFront(segmentedControl)
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        target.center = location
        target.isHidden = false
        segmentedControl.isEnabled = false
        viewModel.onTap(location) {
            self.segmentedControl.isEnabled = true
        }
    }
    
    @IBAction func segmentedControlTapped(_ sender: AnimatorsSegmentedControl) {
        viewModel.transport.locationAnimator = sender.getCurrentAnimtor(for: viewModel.transport.view.center)
    }

}

extension ViewController: TransportAnimationVCDelegate {
    var center: CGPoint {
        return view.center
    }
    
    var size: CGSize {
        return view.frame.size
    }
}

