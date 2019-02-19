//
//  MenuViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 17/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import SnapKit

struct MenuItem {
    let icon: UIImage
    let title: String
}

class MenuViewController: UIViewController {

    // MARK: Definition Variable

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var menuItems = [
        MenuItem(icon: #imageLiteral(resourceName: "profile"), title: "Profile"),
        MenuItem(icon: #imageLiteral(resourceName: "lists"), title: "Lists"),
        MenuItem(icon: #imageLiteral(resourceName: "bookmark"), title: "Bookmarks"),
        MenuItem(icon: #imageLiteral(resourceName: "moments"), title: "Moments"),
    ]

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(self.view)
        }
    }
}

// MARK: UITableView DataSource

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customMenuHeaderView = CustomMenuHeaderView()
        return customMenuHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuItemCell(style: .default, reuseIdentifier: "CellId")
        let menuItem = menuItems[indexPath.item]
        cell.iconImageView.image = menuItem.icon
        cell.titleLabel.text = menuItem.title
        return cell
    }
}
