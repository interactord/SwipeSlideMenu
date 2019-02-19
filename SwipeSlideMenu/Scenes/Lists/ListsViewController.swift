//
//  ListsViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 20/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class ListsViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Lists"
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        view.addSubview(label)
    }

    private func setupLayout() {
        label.fullScreenEdge()
    }

}
