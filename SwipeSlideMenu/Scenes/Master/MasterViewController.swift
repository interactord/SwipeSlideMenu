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

class MasterViewController: BaseViewController {

    // MARK: Definition Variable

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

    var rightViewController: UIViewController
    var menuViewController: UIViewController

    private let menuOpened = BehaviorRelay<Bool>(value: false)
    private let menuWidth: CGFloat = 300

    // MARK: Life cycle

    init(rightViewController: UIViewController, menuViewController: UIViewController) {
        self.rightViewController = rightViewController
        self.menuViewController = menuViewController
        super.init()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle

    override func setupView() {
        super.setupView()

        view.addSubview(redView)
        view.addSubview(blueView)

        redView.addSubview(rightViewController.view)
        redView.addSubview(darkCoverView)
        blueView.addSubview(menuViewController.view)
    }

    override func setupViewController() {
        super.setupViewController()

        addChild(rightViewController)
        addChild(menuViewController)
    }

    override func setupContraints() {
        super.setupViewController()

        redView.fullScreenAnchor(parentView: view)

        blueView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.redView)
            make.trailing.equalTo(self.redView.snp.leading)
            make.width.equalTo(menuWidth)
        }

        [
            rightViewController.view,
            menuViewController.view,
        ].forEach { view in
            view?.fullScreenEdge()
        }
    }

    // MARK: Binding

    override func setupBindingInput() {
        super.setupBindingInput()

        let panGesture = view.rx.panGesture(configuration: { _, delegate in
            delegate.simultaneousRecognitionPolicy = .never
        }).share(replay: 1)

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
        menuOpened.accept(isMenuOpened)
        isMenuOpened ? self.updateRedViewLeading(offset: menuWidth) : self.updateRedViewLeading(offset: 0)
        performAnimation(isMenuOpened: isMenuOpened)
    }

    func didSelectMenuItem(indexPath: IndexPath) {
        performRightViewCleanUp()
        handleMenu(isMenuOpened: false)

        switch indexPath.item {
        case 0:
            rightViewController = UINavigationController(rootViewController: HomeViewController())
        case 1:
            rightViewController = UINavigationController(rootViewController: ListsViewController())
        case 2:
            rightViewController = BookmarksViewController()
        default:
            let tabBarcontroller = UITabBarController()
            let momentController = UIViewController()
            momentController.navigationItem.title = "Moments"
            momentController.view.backgroundColor = .orange
            let navController = UINavigationController(rootViewController: momentController)
            navController.tabBarItem.title = "Moements"

            tabBarcontroller.viewControllers = [navController]
            rightViewController = tabBarcontroller
        }

        redView.addSubview(rightViewController.view)
        addChild(rightViewController)

        redView.bringSubviewToFront(darkCoverView)
    }

    private func performRightViewCleanUp() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
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
