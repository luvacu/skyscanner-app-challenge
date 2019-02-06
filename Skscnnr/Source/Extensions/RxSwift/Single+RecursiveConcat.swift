//
//  Single+RecursiveConcat.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation
import RxSwift

extension PrimitiveSequenceType where TraitType == SingleTrait {

    /// Recursivelly concats itself if `while` predicate is true for the next element.
    /// Optionally, the recursive concat'd stream can be delayed.
    ///
    /// - Parameters:
    ///   - predicate: A function to test each element for a condition.
    ///   - delaySubscription: (Optional) Relative time shift of the subscription.
    ///   - scheduler: (Optional) Scheduler to run the subscription delay timer on.
    /// - Returns: Observable
    func recursiveConcat(while predicate: @escaping (ElementType) throws -> Bool,
                         delaySubscription: RxTimeInterval? = nil,
                         scheduler: SchedulerType? = nil) -> Observable<ElementType> {
        return primitiveSequence
            .asObservable()
            .concatMap { element -> Observable<ElementType> in
                var output = Observable.just(element)
                if try predicate(element) {
                    let nextIteration = self.recursiveConcat(while: predicate, delaySubscription: delaySubscription, scheduler: scheduler)
                    output = output.concat(nextIteration)

                    if let delay = delaySubscription {
                        let scheduler = scheduler ?? MainScheduler.instance
                        output = output.delaySubscription(delay, scheduler: scheduler)
                    }
                }
                return output
        }
    }
}
