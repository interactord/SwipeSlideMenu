//
//  BaseViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 18/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class BaseViewController: UIViewController {

    let bag = DisposeBag()

    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    let homeViewController = HomeViewController()
    let menuViewController = MenuViewController()

    private var isMenuOpened = false
    private let menuWidth: CGFloat = 300

    override func viewDidLoad() {
        view.backgroundColor = .yellow

        setupViews()
        setupLayout()
        setupBinding()
        setupViewContoller()
        setupViewContollerLayout()
    }

    func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
    }

    func setupLayout() {
        redView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(self.view)
        }

        blueView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.redView)
            make.trailing.equalTo(self.redView.snp.leading)
            make.width.equalTo(menuWidth)
        }
    }

    func setupViewContoller() {

        guard
            let homeView = homeViewController.view,
            let menuView = menuViewController.view
            else { return }

        redView.addSubview(homeView)
        blueView.addSubview(menuView)

        addChild(homeViewController)
        addChild(menuViewController)
    }

    func setupViewContollerLayout() {
        guard
            let homeView = homeViewController.view,
            let menuView = menuViewController.view
            else { return }

        homeView.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(redView)
        }

        menuView.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(blueView)
        }

    }

    func setupBinding() {
        // how do we translate our red view
        let panGesture = view.rx.panGesture(configuration: { _, delegate in
            delegate.simultaneousRecognitionPolicy = .never
        }).share(replay: 1)

        panGesture
            .when(.changed)
            .bind { self.panDragginMenu(gesture: $0) }
            .disposed(by: bag)

        panGesture
            .when(.ended)
            .bind { self.panEndedMenu(gesture: $0) }
            .disposed(by: bag)
    }

    private func panDragginMenu(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var translationX = translation.x

        translationX = isMenuOpened ? translationX + menuWidth : translationX
        translationX = min(menuWidth, translationX)
        translationX = max(0, translationX)

        updateRedViewLeading(offset: translationX)
    }

    private func panEndedMenu(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let offset: CGFloat = translation.x < menuWidth / 2 ? 0 : menuWidth
        isMenuOpened = translation.x < menuWidth / 2 ? false : true
        self.updateRedViewLeading(offset: offset)

        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {

                // leave a reference link down in description below

                self.view.layoutIfNeeded()
            })
    }

    func updateRedViewLeading(offset: CGFloat) {
        redView.snp.updateConstraints { make in
            make.leading.equalTo(self.view).offset(offset)
        }
    }

}
