//
//  CustomMenuHeaderView.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 19/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import SnapKit

class CustomMenuHeaderView: UIView {

    // MARK: Definition Variable

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Scott Moon"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()

    private lazy var usernameLabel: UILabel = {
        let lable = UILabel()
        lable.text = "interactord1"
        return lable
    }()

    private lazy var statsLabel: UILabel = {
        let lable = UILabel()
        lable.text = "42 Following 7081 Followers"
        return lable
    }()

    private lazy var stackView: UIStackView = {
        let arrangedSubviews = [
            UIView(),
            nameLabel,
            usernameLabel,
            SpaceView(space: 16),
            statsLabel,
        ]

        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)

        return stackView
    }()

    // MARK: Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup uiviews in UIView

    private func setupViews() {
        addSubview(stackView)

    }

    // MARK: Layout UIViews...

    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(self)
        }

    }

}
