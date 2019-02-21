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

class HomeViewController: UIViewController {

    // MARK: Definition Variable

    let openBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Open", style: .plain, target: nil, action: nil)
        return barButton
    }()

    let hideBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Hide", style: .plain, target: nil, action: nil)
        return barButton
    }()

    lazy var baseView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        return tableView
    }()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupNavigationItems()
    }

    func setupViews() {
        view.backgroundColor = .red
        view.addSubview(baseView)
    }

    func setupNavigationItems() {
        navigationItem.title = "home"
        navigationItem.leftBarButtonItem = openBarButton
        navigationItem.rightBarButtonItem = hideBarButton
    }

    func setupLayout() {
        baseView.fullScreenEdge()
    }

    private func openMennu() {
    }

    private func hideMenu() {
    }
}

// MARK: TableView Datasource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "Row \(indexPath.item)"
        return cell
    }
}
