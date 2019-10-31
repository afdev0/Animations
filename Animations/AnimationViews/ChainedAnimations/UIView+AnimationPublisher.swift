//
//  AnimationPublisher.swift
//  Animations
//
//  Created by Ariel Fertman on 10/30/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit
import Combine

public typealias UIViewAnimationPublisher = AnyPublisher<Bool, Never>

extension UIView {
    
    static public func animatePublisher(withDuration duration: TimeInterval, animations: @escaping () -> Void) -> UIViewAnimationPublisher {
        return AnimatePublisher(withDuration: duration, animations: animations).eraseToAnyPublisher()
    }
    
    private struct AnimatePublisher: Publisher {
                    
        typealias Output = Bool
        typealias Failure = Never
        
        public let duration: TimeInterval
        public let animations: () -> Void
        
        init(withDuration duration: TimeInterval, animations: @escaping () -> Void) {
            self.duration = duration
            self.animations = animations
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            subscriber.receive(subscription: Inner(self, subscriber))
        }
        
        private typealias Parent = AnimatePublisher        
        private final class Inner<Downstream: Subscriber>: Subscription
        where Downstream.Input == Parent.Output, Downstream.Failure == Parent.Failure {
            
            typealias Input = Downstream.Input
            typealias Failure = Downstream.Failure
            
            private var lock: NSLock
            private var parent: Parent?
            private var downstream: Downstream?
            
            init(_ parent: Parent, _ downstream: Downstream) {
                self.lock = NSLock()
                self.parent = parent
                self.downstream = downstream
            }
            
            func request(_ demand: Subscribers.Demand) {
                guard
                    let ds = self.downstream,
                    let duration = self.parent?.duration,
                    let animations = self.parent?.animations
                else { return }
                
                //lock and animate
                self.lock.lock()
                UIView.animate(withDuration: duration, animations: animations) { result in
                    _ = ds.receive(result)
                }
                self.lock.unlock()
            }
            
            func cancel() {
                self.lock.unlock()
            }
        }
    }
}

extension Publisher where Self == UIViewAnimationPublisher {
    
    public func nextAnimation(withDuration duration: TimeInterval, animations: @escaping () -> Void) -> UIViewAnimationPublisher {
        return self.flatMap ({ _ -> UIViewAnimationPublisher in
            return UIView.animatePublisher(withDuration: duration, animations: animations).eraseToAnyPublisher()
        }).eraseToAnyPublisher()
    }
    
}
