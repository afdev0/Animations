//
//  ChainedAnimationsViewController.swift
//  Animations
//
//  Created by Ariel Fertman on 10/30/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit
import Combine

class ChainedAnimationsViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startChainedAnimations()
    }

    func startChainedAnimations() {
        UIView.animatePublisher(withDuration: 1.0) {
            self.imgView.transform = self.imgView.transform.translatedBy(x: 0, y: 100)
        }.nextAnimation(withDuration: 1.0) {
            self.imgView.transform = self.imgView.transform.translatedBy(x: 100, y: 0)
        }.nextAnimation(withDuration: 1.0) {
            self.imgView.transform = self.imgView.transform.translatedBy(x: -100, y: 0)
        }.nextAnimation(withDuration: 1.0) {
            self.imgView.transform = self.imgView.transform.translatedBy(x: 0, y: -100)
        }.sink { _ in
            print("All animations completed")
        }.store(in: &cancellables)
    }

}
