//
//  BookmarksViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 22/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class BookmarksViewController: BaseViewController {

    private lazy var baseView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func setupView() {
        super.setupView()
        view.backgroundColor = .white
        view.addSubview(baseView)
    }

    override func setupContraints() {
        baseView.fullScreenEdge()
    }

}

extension BookmarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // this is easier for recording lessons because I don't have to register a cell onto my tableview
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Bookmark: \(indexPath.row)"
        return cell
    }
}
