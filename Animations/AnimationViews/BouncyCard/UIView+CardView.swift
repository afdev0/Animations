//
//  UIView+CardView.swift
//  Animations
//
//  Created by Ariel Fertman on 10/20/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func add<T: UIView>(_ subview: T, then closure: (T) -> Void) -> T {
        addSubview(subview)
        closure(subview)
        return subview
    }
    
}

extension UIViewController {
    
    @discardableResult
    func addBouncyCard(cardHeight height: CGFloat = 750, delegate: CardViewDelegate? = nil) -> UIView {
        
        let cardView = CardView(frame: CGRect(
            x: 0,
            y: self.view.frame.height - self.view.frame.height / 5 * 4,
            width: self.view.frame.width,
            height: height
        ))
            
        view.add(cardView, then: {
            // Setup delegate
            $0.delegate = delegate
            // Setup cardview contraints
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraints([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                $0.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 5 * 4),
                $0.widthAnchor.constraint(equalTo: view.widthAnchor),
                $0.heightAnchor.constraint(equalToConstant: height),
            ])
        })
        
        return cardView
    }    
}
