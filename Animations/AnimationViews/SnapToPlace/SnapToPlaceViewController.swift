//
//  SnapToPlaceViewController.swift
//  Animations
//
//  Created by Ariel Fertman on 10/10/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit
import Combine

class SnapToPlaceViewController: UIViewController {

    @IBOutlet weak var catImg: UIImageView!
    @IBOutlet weak var dampingSlider: UISlider!
    
    var animator: UIDynamicAnimator!
    var snapBehavior: UISnapBehavior!
    @Published var damping: CGFloat = 0.5
    
    private var subs = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Cat image 
        catImg.backgroundColor = UIColor.black
        catImg.layer.cornerRadius = 8.0
        catImg.layer.borderWidth = 3
        catImg.layer.borderColor = UIColor.black.cgColor
        catImg.isUserInteractionEnabled = true
        
        dampingSlider.value = Float(damping)
        
        // Add pan gesture
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SnapToPlaceViewController.handlePan(recognizer:)))
        
        catImg.addGestureRecognizer(panGestureRecognizer)
        
        // Setu[ UIDyanmics to snap card back to center after pan
        animator = UIDynamicAnimator(referenceView: view)
        snapBehavior = UISnapBehavior(item: catImg, snapTo: view.center)
        
        $damping.sink { newDampingValue in
            self.snapBehavior.damping = newDampingValue
        }.store(in: &subs)
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animator.removeBehavior(snapBehavior)
        case .changed:
            let translation = recognizer.translation(in: view)
            catImg.center = CGPoint(
                x: catImg.center.x + translation.x,
                y: catImg.center.y + translation.y
            )
            recognizer.setTranslation(.zero, in: view)
        case .ended, .cancelled, .failed:
            animator.addBehavior(snapBehavior)
        default:
            break
        }
    }
    
    
    @IBAction func onDampingUpdate(_ slider: UISlider) {
        damping = CGFloat(slider.value)
    }
    
}
