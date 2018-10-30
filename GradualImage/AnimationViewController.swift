//
//  AnimationViewController.swift
//  GradualImage
//
//  Created by Agust Rafnsson on 2018-10-29.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import UIKit

class AnimationViewController: VerticalPanViewController {
    var images: [UIImage] = []

    @IBOutlet weak var animationImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        var garfieldUrls =  Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: "cats") ?? []
        garfieldUrls = garfieldUrls.sorted(by: { (url1, url2) -> Bool in
            url1.absoluteString < url2.absoluteString
        })
        for url in garfieldUrls {
            if let image = UIImage(contentsOfFile: url.path) {
                self.images.append(image)
            }
        }
        
        self.animationImageView.image = self.images[Int(floor(CGFloat(images.count) * self.fractionFinished))]
    }
    
    override func myActionMethod(_ sender: UIGestureRecognizer) {
        super.myActionMethod(sender)
        if sender == self.pangestureRecognizer {
            let imageIndex = Int(floor(CGFloat(images.count) * self.intermediateFractionFinished))
            print("imageindex: \(imageIndex)")
            print("\(self.fractionFinished)")
            if 0 <= imageIndex, imageIndex < self.images.count {
                self.animationImageView.image = self.images[imageIndex]
            }
        }
    }
}
