//
//  GravityViewController.swift
//  Animations
//
//  Created by Ariel Fertman on 10/10/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit

class GravityViewController: UIViewController {
    
    enum RockState {
        case floating
        case dropped
    }
    
    @IBOutlet weak var rockImage: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    @Published var nextRockState: RockState = .dropped
    
    var animator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    
    var originalPosition: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalPosition = rockImage.center
        
        // Initialize Gravity and Collisions
        animator = UIDynamicAnimator(referenceView: view)
        gravityBehavior = UIGravityBehavior(items: [rockImage])
        collisionBehavior = UICollisionBehavior(items: [rockImage])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
    }
    
    @IBAction func onDrop(_ button: UIButton) {
        switch nextRockState {
        case .floating:
            animator.removeBehavior(gravityBehavior)
            animator.removeBehavior(collisionBehavior)
            rockImage.center = originalPosition
            button.setTitle("Dropped", for: .normal)
            nextRockState = .dropped
        case .dropped:
            animator.addBehavior(gravityBehavior)
            animator.addBehavior(collisionBehavior)
            button.setTitle("Reset", for: .normal)
            nextRockState = .floating
        }
        
    }
    
}
