//
//  BouncyCardViewController.swift
//  Animations
//
//  Created by Ariel Fertman on 10/11/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit

class BouncyCardViewController: UIViewController {
                    
    lazy var visualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        return visualEffectView
    }()
    
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
        self.view.addSubview(visualEffectView)
        
        // Setup card
        cardView = CardView(frame: CGRect(
            x: 0,
            y: self.view.frame.height - self.view.frame.height / 5 * 4,
            width: self.view.frame.width,
            height: 750)
        )
        self.view.addSubview(cardView)
        cardView.delegate = self


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

extension BouncyCardViewController: CardViewDelegate {
    
    func cardStateWillChange(nextState state: CardView.CardState) {
        UIView.animate(withDuration: 1.0, animations: {
            switch state {
            case .expanded:
                self.visualEffectView.effect = UIBlurEffect(style: .light)
            case .collapsed:
                self.visualEffectView.effect = nil
            }
        })
    }
    
}
