//
//  BaseViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 21/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {

    // MARK: Definition Variable

    var bag = DisposeBag()

    private(set) var didSetupConstaints = false

    // MARK: Initializer

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }

    // MARK: Life cycle
    override func viewDidLoad() {
        setupView()
        setupViewController()
        self.view.setNeedsUpdateConstraints()
        setupBindingInput()
        setupBindingOutput()
    }

    override func updateViewConstraints() {
        if !didSetupConstaints {
            setupContraints()
            didSetupConstaints = true
        }
        super.updateViewConstraints()
    }

    func setupView() { }

    func setupViewController() { }

    func setupContraints() { }

    func setupBindingInput() { }

    func setupBindingOutput() { }
}
