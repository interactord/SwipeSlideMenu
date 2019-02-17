//
//  ContentsViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 17/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        view.backgroundColor = .red

        setNavigation()
        setViews()
        setLayout()
    }

    func setNavigation() {
        navigationItem.title = "home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }

    @objc func handleOpen() {
        print("Opening menu...")
    }

    @objc func handleHide() {
        print("Hidding menu...")
    }

    func setViews() {
    }

    func setLayout() {
    }
}

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
