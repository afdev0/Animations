//
//  BouncyCardViewController.swift
//  Animations
//
//  Created by Ariel Fertman on 10/11/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    // Mark: Animations
    var dynamicAnimator: UIDynamicAnimator!
    var gravityBevahior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    
    // MARK: View Calculations & Constants
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    var isCardVisible = false
    var nextState: CardState {
        return isCardVisible ? .collapsed : .expanded
    }
    
    let handleArea: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.alpha = 0.3
        return view
    }()
    
    private var handleIcon: UIImageView = {
        let img = UIImage(systemName: "line.horizontal.3")!
        let view = UIImageView(image: img)
        view.tintColor = .black
        view.contentMode = .top
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true        
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        setupInnerViews()
        setupGestures()
        setupAnimations()
    }
    
    private func setupInnerViews() {
        // Setup card sub views
        self.addSubview(handleArea)
        self.addSubview(handleIcon)

        // Setup card icon
        handleIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
           handleIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
           handleIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
           handleIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        ])

        // Setup card handle area
        handleArea.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
           handleArea.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
           handleArea.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
           handleArea.widthAnchor.constraint(equalTo: self.widthAnchor),
           handleArea.heightAnchor.constraint(equalToConstant: 50),
           handleArea.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }
    
    // MARK: Gestures
    
    func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CardView.handleCardTap(recognizer:)))
        self.handleArea.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            cardTransition()
        default:
            break
        }
    }
    
    //MARK: Animations
    
    func setupAnimations() {
        guard let parent = self.superview else {
            print("Unable to determine superview")
            return
        }
        dynamicAnimator = UIDynamicAnimator(referenceView: parent)
        collisionBehavior = UICollisionBehavior(items: [self])
        gravityBevahior = UIGravityBehavior(items: [self])
        itemBehavior = UIDynamicItemBehavior(items: [self])
        
        itemBehavior.elasticity = 0.4
        gravityBevahior.gravityDirection = CGVector(dx: 0, dy: -1.0)
        
        let height = parent.bounds.height - self.frame.height / 5 * 4
        collisionBehavior.addBoundary(
            withIdentifier: "Top Boundry" as NSCopying,
            from: CGPoint(x: 0, y: height),
            to: CGPoint(x: parent.bounds.width, y: height)
        )
    }
    
     func cardTransition() {
        guard let parent = superview else {
            print("Unable to determine superview for card transition")
            return
        }
        UIView.animate(withDuration: 1.0, animations: {
            switch self.nextState {
            case .expanded:
                //self.visualEffectView.effect = UIBlurEffect(style: .light)
                self.dynamicAnimator.addBehavior(self.collisionBehavior)
                self.dynamicAnimator.addBehavior(self.gravityBevahior)
            case .collapsed:
                self.dynamicAnimator.removeAllBehaviors()
                self.frame.origin.y = parent.frame.height - parent.frame.height / 5
                //self.visualEffectView.effect = nil
            }
        }) { _ in
            self.isCardVisible = !self.isCardVisible
        }
    }
}

class BouncyCardViewController: UIViewController {
                    
    // MARK: Custom Views
    
    
    private var cardView: CardView!
    
    //MARK: View Controller Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: View Constraints & Setup
    
    func setupViews() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "iOS-13-Stock-Wallpaper-Orange-Light"))

        // Add blur effect
//        visualEffectView = UIVisualEffectView()
//        visualEffectView.frame = self.view.frame
//        self.view.addSubview(visualEffectView)
        
        // Setup card
        cardView = CardView(frame: CGRect(
            x: 0,
            y: self.view.frame.height - self.view.frame.height / 5 * 4,
            width: self.view.frame.width,
            height: 750)
        )
        self.view.addSubview(cardView)


        // Setup cardview contraints
        cardView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            cardView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height / 5 * 4),
            cardView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 750),
        ])
    }
    
}
