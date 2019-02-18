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

typealias TranslationType = (translation: CGPoint, velocity: CGPoint)

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

        let menuOpened = BehaviorRelay<Bool>(value: false)
        let touchMovedGesture = panGesture.when(.changed).asTranslation()
        let touchEndedGesture = panGesture.when(.ended).asTranslation()

        Observable
            .combineLatest(touchMovedGesture, menuOpened) { [weak self] (transiton, menuOpend) -> CGFloat in
                guard let strongSelf = self else { return 0 }
                return strongSelf.panDragginMenu(translation: transiton, isMenuOpened: menuOpend)
            }
            .subscribe(onNext: { [weak self] transitionX in
                guard let strongSelf = self else { return }
                strongSelf.darkCoverView.alpha = transitionX / strongSelf.menuWidth
                strongSelf.updateRedViewLeading(offset: transitionX)
            })
            .disposed(by: bag)

        Observable
            .zip(touchEndedGesture, menuOpened) {
                self.panEndedMenu(translation: $0, isMenuOpened: $1)
            }
            .subscribe(onNext: { [weak self] result in
                guard let strongSelf = self else { return }
                menuOpened.accept(result)
                strongSelf.handleMenu(isMenuOpened: result)
            })
            .disposed(by: bag)
    }

    // MARK: Setup PanGesuture

    private func panDragginMenu(translation: TranslationType, isMenuOpened: Bool) -> CGFloat {
        var translationX = translation.translation.x

        translationX = isMenuOpened ? translationX + menuWidth : translationX
        translationX = min(menuWidth, translationX)
        translationX = max(0, translationX)
        return translationX
    }

    private func panEndedMenu(translation: TranslationType, isMenuOpened: Bool) -> Bool {
        let velocityThreshold: CGFloat = 500

        if abs(translation.velocity.x) > velocityThreshold {
            return !isMenuOpened
        }

        if abs(translation.translation.x) < menuWidth / 2 {
            return isMenuOpened
        }

        return !isMenuOpened
    }

    func updateRedViewLeading(offset: CGFloat) {
        redView.snp.updateConstraints { make in
            make.leading.equalTo(self.view).offset(offset)
        }
    }

    func handleMenu(isMenuOpened: Bool) {
        isMenuOpened ? self.updateRedViewLeading(offset: menuWidth) : self.updateRedViewLeading(offset: 0)
        performAnimation(isMenuOpened: isMenuOpened)

    }

    // MARK: Animated

    func performAnimation(isMenuOpened: Bool) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.view.layoutIfNeeded()
                strongSelf.darkCoverView.alpha = isMenuOpened ? 1 : 0
            })
    }

}
