//
//  SeachViewContainer.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 23/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import SnapKit

class SeachViewContainer: BaseViewController {

    private(set) lazy var seachBar: UISearchBar = {
        let seachBar = UISearchBar()
        seachBar.searchBarStyle = .minimal
        seachBar.placeholder = "Enter some filter"
        return seachBar
    }()

    private(set) lazy var rocketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "rocket")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()

    override func setupView() {
        super.setupView()

        view.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.1843137255, blue: 0.2470588235, alpha: 1)

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white

        view.addSubview(seachBar)
        view.addSubview(rocketImageView)
    }

    override func setupContraints() {
        super.setupContraints()

        rocketImageView.anchor(
            top: nil,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 10, bottom: 10, right: 0),
            size: .init(width: 44, height: 44))

        seachBar.anchor(
            top: nil,
            leading: rocketImageView.trailingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 4, right: 0)
        )

    }
}
