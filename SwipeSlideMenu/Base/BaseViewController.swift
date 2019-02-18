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

    // MARK: Definition Variable

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

    let darkCoverView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        return view
    }()

    let homeViewController = HomeViewController()
    let menuViewController = MenuViewController()

    private let menuWidth: CGFloat = 300
    private let velocityThreshold: CGFloat = 500
    private var isMenuOpened = false

    // MARK: Life cycle

    override func viewDidLoad() {
        view.backgroundColor = .yellow

        setupViews()
        setupLayout()
        setupBinding()
        setupViewContoller()
        setupViewContollerLayout()
    }

    // MARK: Setup uiviews in UIViewController

    func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
    }

    func setupViewContoller() {

        guard
            let homeView = homeViewController.view,
            let menuView = menuViewController.view
            else { return }

        redView.addSubview(homeView)
        redView.addSubview(darkCoverView)
        blueView.addSubview(menuView)

        addChild(homeViewController)
        addChild(menuViewController)
    }

    // MARK: Layout UIViews...

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

    func setupViewContollerLayout() {
        guard
            let homeView = homeViewController.view,
            let menuView = menuViewController.view
            else { return }

        homeView.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(redView)
        }

        darkCoverView.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(redView)
        }

        menuView.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(blueView)
        }

    }

    // MARK: Binding

    func setupBinding() {
        // how do we translate our red view
        let panGesture = view.rx.panGesture(configuration: { _, delegate in
            delegate.simultaneousRecognitionPolicy = .never
        }).share(replay: 1)

        panGesture
            .when(.changed)
            .asTranslation()
            .flatMapLatest(panDragginMenu)
            .bind { transitionX in
                self.darkCoverView.alpha = transitionX / self.menuWidth
                self.updateRedViewLeading(offset: transitionX)
            }
            .disposed(by: bag)

        panGesture
            .when(.ended)
            .asTranslation()
            .flatMapLatest(panEndedMenu)
            .bind { isOpen in
                isOpen ? self.openMenu() : self.closeMenu()
            }
            .disposed(by: bag)
    }

    // MARK: Setup PanGesuture

    private func panDragginMenu(translation: CGPoint, velocity: CGPoint) -> Observable<CGFloat> {
        var translationX = translation.x

        translationX = isMenuOpened ? translationX + menuWidth : translationX
        translationX = min(menuWidth, translationX)
        translationX = max(0, translationX)
        return Observable.just(translationX)
    }

    private func panEndedMenu(translation: CGPoint, velocity: CGPoint) -> Observable<Bool> {

        if abs(velocity.x) > velocityThreshold {
            return Observable.just(!isMenuOpened)
        }

        if abs(translation.x) < menuWidth / 2 {
            isMenuOpened ? openMenu() : closeMenu()
            return Observable.just(isMenuOpened)
        }

        return Observable.just(!isMenuOpened)
    }

    func updateRedViewLeading(offset: CGFloat) {
        redView.snp.updateConstraints { make in
            make.leading.equalTo(self.view).offset(offset)
        }
    }

    func openMenu() {
        isMenuOpened = true
        self.updateRedViewLeading(offset: menuWidth)
        performAnimation()
    }

    func closeMenu() {
        isMenuOpened = false
        self.updateRedViewLeading(offset: 0)
        performAnimation()
    }

    // MARK: Animated

    func performAnimation() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.view.layoutIfNeeded()
                self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
            })
    }

}
