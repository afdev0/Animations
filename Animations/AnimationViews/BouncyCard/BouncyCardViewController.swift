//
//  BouncyCardViewController.swift
//  Animations
//
//  Created by Ariel Fertman on 10/11/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit

class CardView: UIView {
    
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
}

class BouncyCardViewController: UIViewController {
        
    // MARK: View Calculations & Constants
    
    struct CardHeight {
        static let cardArea: CGFloat = 750
        static let handleArea: CGFloat = 50
    }
    
    var cardCollapsedHeight: CGFloat {
        return self.view.frame.height / 5 * 4
    }
    
    var cardExpandedHeight: CGFloat {
        return self.view.frame.height / 3
    }
    
    // Mark: Animations
        
    var animator = UIViewPropertyAnimator(duration: 0.9, dampingRatio: 1)
    var visualEffectView:UIVisualEffectView!
    var animationProgress: CGFloat = 0
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    var isCardVisible = false
    var nextState: CardState {
        return isCardVisible ? .collapsed : .expanded
    }
    
    // MARK: Custom Views

    private var cardView: UIView!
    
    private let cardHandleArea: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.alpha = 0.3
        return view
    }()
    
    private var cardHandleIcon: UIImageView = {
        let img = UIImage(systemName: "line.horizontal.3")!
        let view = UIImageView(image: img)
        view.tintColor = .black
        view.contentMode = .top
        return view
    }()
    
    //MARK: View Controller Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()
    }
    
    // MARK: View Constraints & Setup
    
    func setupViews() {
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "iOS-13-Stock-Wallpaper-Orange-Light"))

        // Add blur effect
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        // Setup card
        cardView = CardView(frame: CGRect(
            x: 0,
            y: self.view.frame.height - cardCollapsedHeight,
            width: self.view.frame.width,
            height: CardHeight.cardArea)
        )
        self.view.addSubview(cardView)


        // Setup cardview contraints
        cardView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            cardView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: cardCollapsedHeight),
            cardView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            cardView.heightAnchor.constraint(equalToConstant: CardHeight.cardArea),
        ])
              
        // Setup card sub views
        cardView.addSubview(cardHandleArea)
        cardView.addSubview(cardHandleIcon)

        // Setup card icon
        cardHandleIcon.translatesAutoresizingMaskIntoConstraints = false
        cardView.addConstraints([
            cardHandleIcon.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            cardHandleIcon.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            cardHandleIcon.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
        ])

        // Setup card handle area
        cardHandleArea.translatesAutoresizingMaskIntoConstraints = false
        cardView.addConstraints([
            cardHandleArea.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            cardHandleArea.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0),
            cardHandleArea.widthAnchor.constraint(equalTo: cardView.widthAnchor),
            cardHandleArea.heightAnchor.constraint(equalToConstant: CardHeight.handleArea),
            cardHandleArea.topAnchor.constraint(equalTo: cardView.topAnchor),
        ])
    }
    
    // MARK: Gestures
    
    func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BouncyCardViewController.handleCardTap(recognizer:)))
            
        cardHandleArea.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            startInteractiveTransition()
        default:
            break
        }
    }
    
    //MARK: Animations
    
     func startInteractiveTransition() {
        animator.addAnimations {
            switch self.nextState {
            case .expanded:
                self.cardView.frame.origin.y = self.view.frame.height - CardHeight.cardArea
                self.visualEffectView.effect = UIBlurEffect(style: .light)
            case .collapsed:
                self.cardView.frame.origin.y = self.view.frame.height - self.cardCollapsedHeight / 4
                self.visualEffectView.effect = nil
            }
        }
        animator.addCompletion { _ in
            self.isCardVisible = !self.isCardVisible
        }
        animator.startAnimation()
    }
    
}
