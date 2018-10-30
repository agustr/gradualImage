//
//  GlidingInImageViewController.swift
//  GradualImage
//
//  Created by Agust Rafnsson on 2018-10-26.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import UIKit

class VerticalPanViewController: UIViewController {
    var pangestureRecognizer: UIPanGestureRecognizer!
    // gliding image current value
    
    var intermediateFractionFinished: CGFloat = 0 {
        didSet{
            if intermediateFractionFinished > 1 {
                self.fractionFinished = 1
            } else if self.intermediateFractionFinished < 0 {
                self.fractionFinished = 0
            } else {
                self.fractionFinished = self.intermediateFractionFinished
            }
        }
    }
    
    var fractionFinished: CGFloat = 0
    
    var intermediateValue: CGFloat = 0 {
        didSet {
            self.intermediateFractionFinished = intermediateValue / maxValue
        }
    }
    
    var value: CGFloat = 0 {
        didSet {
            self.fractionFinished = value / maxValue
        }
    }
    
    var maxValue: CGFloat = 0
    var minValue: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pangestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.myActionMethod(_:)))
        self.view.addGestureRecognizer(pangestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        maxValue = self.view.frame.maxY
    }
    
    @objc func myActionMethod(_ sender: UIGestureRecognizer){
        if sender == pangestureRecognizer {self.intermediateValue = self.value - self.pangestureRecognizer.translation(in: self.view).y
            switch sender.state{
            case .changed:
                self.intermediateValue = self.value - self.pangestureRecognizer.translation(in: self.view).y
            case .ended:
                if self.intermediateValue > maxValue {
                    self.value = maxValue
                } else if self.intermediateValue < minValue {
                    self.value = minValue
                } else {
                    self.value = intermediateValue
                }
            case .cancelled, .failed, .possible, .began:
                break
            }
        }
    }
}
