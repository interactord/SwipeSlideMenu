//
//  ContentsViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 17/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class HomeViewController: UITableViewController {

    // MARK: Definition Variable

    let bag = DisposeBag()

    let openBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Open", style: .plain, target: nil, action: nil)
        return barButton
    }()

    let hideBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Hide", style: .plain, target: nil, action: nil)
        return barButton
    }()

    let darkCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        view.alpha = 0
        view.isUserInteractionEnabled = false
        return view
    }()

    let mainWindow: UIWindow? = {
        let window = UIApplication.shared.keyWindow
        return window
    }()

    private let menuWith: CGFloat = 300
    private var isMenuOpened = false
    private let velocityOpenThreshold: CGFloat = 500

    private let menuViewController = MenuViewController()

    // MARK: Life cycle

    override func viewDidLoad() {
        view.backgroundColor = .red

        setNavigation()
        setupViews()
        setBinding()
    }

    private func setNavigation() {
        navigationItem.title = "home"
        navigationItem.leftBarButtonItem = openBarButton
        navigationItem.rightBarButtonItem = hideBarButton
    }

    private func setupViews() {
        menuViewController.view.frame = CGRect(x: -menuWith, y: 0, width: menuWith, height: view.frame.height)
        mainWindow?.addSubview(menuViewController.view)
        addChild(menuViewController)

        darkCoverView.frame = mainWindow?.frame ?? .zero
        mainWindow?.addSubview(darkCoverView)
    }

    private func setBinding() {
        openBarButton.rx.tap
            .bind { _ in self.openMennu() }
            .disposed(by: bag)

        hideBarButton.rx.tap
            .bind { _ in self.hideMenu() }
            .disposed(by: bag)

//        let panGesture = view.rx.panGesture().share(replay: 1)
//
//        panGesture
//            .when(.changed)
//            .asTranslation()
//            .bind { self.panDragginMenu(translation: $0, velocity: $1) }
//            .disposed(by: bag)
//
//        panGesture
//            .when(.ended)
//            .asTranslation()
//            .bind { self.panEndedMenu(translation: $0, velocity: $1) }
//            .disposed(by: bag)

    }

    private func openMennu() {
        isMenuOpened = true
        performAnimations(transform: CGAffineTransform(translationX: menuWith, y: 0))
    }

    private func hideMenu() {
        isMenuOpened = false
        performAnimations(transform: .identity)
    }

    private func performAnimations(transform: CGAffineTransform) {

        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.menuViewController.view.transform = transform
                self.navigationController?.view.transform = transform
                self.darkCoverView.transform = transform

                self.darkCoverView.alpha = transform == .identity ? 0 : 1
            })
    }

    private func panDragginMenu(translation: CGPoint, velocity: CGPoint) {

        var translationX = translation.x

        if isMenuOpened {
            translationX += menuWith
        }

        translationX = min(menuWith, translationX)
        translationX = max(0, translationX)

        let transform = CGAffineTransform(translationX: translationX, y: 0)
        menuViewController.view.transform = transform
        navigationController?.view.transform = transform
        darkCoverView.transform = transform

        darkCoverView.alpha = translationX / menuWith
    }

    private func panEndedMenu(translation: CGPoint, velocity: CGPoint) {
        if isMenuOpened {
            if abs(velocity.x) > velocityOpenThreshold {
                hideMenu()
                return
            }

            if abs(translation.x) < menuWith / 2 {
                openMennu()
            } else {
                hideMenu()
            }
        } else {

            if abs(velocity.x) > velocityOpenThreshold {
                openMennu()
                return
            }

            if translation.x < menuWith / 2 {
                hideMenu()
            } else {
                openMennu()
            }
        }

    }
}

// MARK: TableView Datasource

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "Row \(indexPath.item)"
        return cell
    }
}
