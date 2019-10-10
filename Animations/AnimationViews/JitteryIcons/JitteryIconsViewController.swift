//
//  JitteryIconsViewController.swift
//  Animations
//
//  Created by Ariel Fertman on 10/9/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit

class JitteryIconsViewController: UIViewController {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var animationCancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        icon.isUserInteractionEnabled = true
        animationCancelBtn.alpha = 0.0
        animationCancelBtn.tintColor = UIColor.gray

        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(JitteryIconsViewController.handleIconLongPress(recognizer:)))
        longPressGestureRecognizer.minimumPressDuration = 1.0
        
        icon.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        icon.layer.removeAllAnimations()
        animationCancelBtn.alpha = 0.0
    }
    
    @objc func handleIconLongPress(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            print("Start jitter animation")
            animationCancelBtn.fade(options: .curveEaseIn, toAlpha: 1.0)
            self.icon.shake()
            break
        default:
            break
        }
    }
    
    @IBAction func onAnimationCancel(_ sender: Any) {
        icon.layer.removeAllAnimations()
        animationCancelBtn.fade(options: .curveEaseOut, toAlpha: 0.0)
    }
    
}

extension UIView {
    
    func shake() {
        let values = [-10, 10, -5, 5, -10, 10]
        
        let animationX = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animationX.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animationX.duration = 0.8
        animationX.repeatCount = .infinity
        animationX.autoreverses = true
        animationX.values = values
        layer.add(animationX, forKey: "shakeX")
        
        let animationX2 = animationX
        animationX2.values = values.reversed()
        layer.add(animationX2, forKey: "shakeX2")
        
        let animationY = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animationY.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animationY.duration = 0.8
        animationY.repeatCount = .infinity
        animationY.autoreverses = true
        animationY.values = [-10, 10, -10, 10, -5, 5, 0, -10, 10]
        layer.add(animationY, forKey: "shakeY")
    }
    
    func fade(options: UIView.AnimationOptions, toAlpha alpha: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: options, animations: {
            self.alpha = alpha
        })
    }
        
}
