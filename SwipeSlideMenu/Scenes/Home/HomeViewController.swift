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

    fileprivate let menuWith: CGFloat = 300

    fileprivate let menuViewController: MenuViewController = {
        let viewController = MenuViewController()
        return viewController
    }()

    // MARK: Life cycle

    override func viewDidLoad() {
        view.backgroundColor = .red

        setNavigation()
        setViews()
        setLayout()
        setBinding()
    }

    func setNavigation() {
        navigationItem.title = "home"
        navigationItem.leftBarButtonItem = openBarButton
        navigationItem.rightBarButtonItem = hideBarButton
    }

    @objc func handleHide() {
        print("Hidding menu...")
    }

    func setViews() {
    }

    func setLayout() {
    }

    func setBinding() {
        openBarButton.rx.tap
            .bind { _ in self.openMennu() }
            .disposed(by: bag)

        hideBarButton.rx.tap
            .bind { _ in self.hideMenu() }
            .disposed(by: bag)
    }

    func openMennu() {

        menuViewController.view.frame = CGRect(x: -menuWith, y: 0, width: menuWith, height: view.frame.height)

        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuViewController.view)
        addChild(menuViewController)

        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.menuViewController.view.transform = CGAffineTransform(translationX: self.menuWith, y: 0)
            })

    }

    func hideMenu() {
        print("Hidding menu...")

        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.menuViewController.view.transform = .identity
            },
            completion: { _ in
                self.menuViewController.view.removeFromSuperview()
                self.menuViewController.removeFromParent()
            })
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
