//
//  MenuViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 17/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
    }
}

// MARK: UITableView DataSource

extension MenuViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customMenuHeaderView = CustomMenuHeaderView()
        return customMenuHeaderView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellId")
        cell.textLabel?.text = "menu item \(indexPath.item)"
        return cell
    }
}
