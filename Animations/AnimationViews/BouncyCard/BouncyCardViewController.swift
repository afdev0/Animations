//
//  BouncyCardViewController.swift
//  Animations
//
//  Created by Ariel Fertman on 10/11/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit

class BouncyCardViewController: UIViewController {
    
    // MARK: View Calculations & Constants
    
    struct CardHeight {
        static let cardArea: CGFloat = 600
        static let handleArea: CGFloat = 50
    }
    
    var cardCollapsedHeight: CGFloat {
        return self.view.frame.height / 5 * 4
    }
    
    var cardExpandedHeight: CGFloat {
        return self.view.frame.height / 3
    }
    
    // MARK: Custom Views

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
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
    }
    
    // MARK: View Constraints & Setup
    
    func setupViews() {
        self.view.backgroundColor = .white
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
    
}
