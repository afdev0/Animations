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
        icon.backgroundColor = UIColor.red
        icon.layer.cornerRadius = 8.0
        icon.clipsToBounds = true
        
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

extension UIView: CAAnimationDelegate {
    
    func shake() {
        let radians = currentRadianVal()
        let animate = CABasicAnimation(keyPath: "transform.rotation")
        animate.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animate.duration = 0.2
        animate.repeatCount = .infinity
        animate.autoreverses = true
        animate.fromValue = radians + 0.05
        animate.toValue = radians - 0.05
        layer.add(animate, forKey: "rotate")
    }
    
    func currentRadianVal() -> Float {
        return atan2f(Float(transform.b), Float(transform.a));
    }
    
    func fade(options: UIView.AnimationOptions, toAlpha alpha: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: options, animations: {
            self.alpha = alpha
        })
    }
        
}
