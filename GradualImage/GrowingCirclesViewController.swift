//
//  GrowingCirclesViewController.swift
//  GradualImage
//
//  Created by Agust Rafnsson on 2018-10-30.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import UIKit

class GrowingCirclesViewController: VerticalPanViewController {
    var imageViews: [UIImageView] = []
    var numberOfCircles = 30

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imagesUrls = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: "circles")
        let images = imagesUrls?.compactMap({ (url) -> UIImage? in
            return UIImage(contentsOfFile: url.path)
        })
        
        for _ in 0..<numberOfCircles {
            let imgView = UIImageView(image: images?.randomElement())
            imgView.frame.size = CGSize.zero
            imgView.isUserInteractionEnabled = false
            imgView.contentMode = .scaleAspectFill
            self.imageViews.append(imgView)
        }
        for imageview in self.imageViews {
            self.view.addSubview(imageview)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let centerBottom = CGPoint(x: self.view.frame.maxX / 2, y: self.view.frame.maxY)
        self.imageViews.forEach { (imageView) in
            imageView.center = centerBottom
        }
    }
    
    override func myActionMethod(_ sender: UIGestureRecognizer) {
        
        super.myActionMethod(sender)
        
        let centerBottom = CGPoint(x: self.view.frame.maxX / 2, y: self.view.frame.maxY)
        let imageIndex = Int(floor(CGFloat(imageViews.count) * self.intermediateFractionFinished))
        
        for (index, view) in self.imageViews.enumerated(){
            if index <= imageIndex {
                view.isHidden = false
            } else {
                view.isHidden = true
            }
        }
        
        let stepsize = self.maxValue / CGFloat(self.imageViews.count)
        

        if 0 <= imageIndex, imageIndex < self.imageViews.count {
            print("Index: \(imageIndex), stepsize:\(stepsize), ")
            let currentImageView = imageViews[imageIndex]
            let maxImageHeight = self.maxSizeForImageAt(index: imageIndex)
            let sizeOfImage = self.intermediateValue * 2 * (1-((maxImageHeight-self.intermediateValue)/stepsize))
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
                currentImageView.frame.size = CGSize(width: sizeOfImage, height: sizeOfImage)
                currentImageView.center = centerBottom
                self.view.layoutSubviews()
            }) { (finished) in
                //
            }

        }
    }
    func maxSizeForImageAt(index: Int) -> CGFloat {
        if 0 <= index, index < self.imageViews.count {
            return (self.maxValue / CGFloat(self.imageViews.count)) * CGFloat(index + 1)
        } else {
            return 0
        }
    }
}
