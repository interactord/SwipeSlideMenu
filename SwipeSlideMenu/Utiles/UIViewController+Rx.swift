//
//  UIViewController+Rx.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 20/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension UIViewController {

    private func trigger(selector: Selector) -> Observable<Void> {
        return rx.sentMessage(selector).map { _ in () }.share(replay: 1)
    }

    var viewDidLoadTrigger: Observable<Void> {
        return trigger(selector: #selector(self.viewDidLoad))
    }

    var viewWillAppearTrigger: Observable<Void> {
        return trigger(selector: #selector(self.viewWillAppear(_:)))
    }

    var viewDidAppearTrigger: Observable<Void> {
        return trigger(selector: #selector(self.viewDidAppear(_:)))
    }

    var viewWillDisappearTrigger: Observable<Void> {
        return trigger(selector: #selector(self.viewWillDisappear(_:)))
    }

    var viewDidDisappearTrigger: Observable<Void> {
        return trigger(selector: #selector(self.viewDidDisappear(_:)))
    }

}
