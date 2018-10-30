//
//  GlidingInImageViewController.swift
//  GradualImage
//
//  Created by Agust Rafnsson on 2018-10-26.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import UIKit

class GlidingInImageViewController: VerticalPanViewController {
    @IBOutlet weak var leadingLineConstraint: NSLayoutConstraint!
    @IBOutlet weak var fromBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    // gliding image current value
    
    @IBOutlet weak var bouncingImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "stripes")
        self.bouncingImageView.image = image
        self.bouncingImageView.backgroundColor = UIColor.red
        self.imageView.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        maxValue = self.view.frame.maxY
    }
    
    override func myActionMethod(_ sender: UIGestureRecognizer){
        super.myActionMethod(sender)
        if sender == pangestureRecognizer {
            
            self.intermediateValue = self.value - self.pangestureRecognizer.translation(in: self.view).y
            let velocityValue = self.pangestureRecognizer.velocity(in: self.view).y
            self.view.layer.removeAllAnimations()
            
            switch sender.state{
            case .changed:
                self.fromBottomConstraint.constant = intermediateValue
                
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
                    self.leadingLineConstraint.constant = velocityValue/3
                    self.view.layoutIfNeeded()
                }) { (finished) in
                    //
                }
            case .ended:

                UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
                    self.leadingLineConstraint.constant = 0
                    self.fromBottomConstraint.constant = self.value
                    self.view.layoutIfNeeded()
                }, completion: { (finished) in
                    //
                })
            case .cancelled, .failed, .possible, .began:
                break
            }
        }
    }
}
