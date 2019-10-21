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
                
    //MARK: View Controller Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubViews()
    }
    
    // MARK: View Constraints & Setup
    
    func setupView() {
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "iOS-13-Stock-Wallpaper-Orange-Light"))
    }
    
    func setupSubViews() {        
        // Setup sub views
        view.addSubview(visualEffectView)
        addBouncyCard(delegate: self)
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
