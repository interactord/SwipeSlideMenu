//
//  MenuItemCell.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 19/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import SnapKit

class MenuItemCell: UITableViewCell {

    // MARK: Definition Variable

    let iconImageView: ImageSpaceView = {
        let imageView = ImageSpaceView(space: 44)
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "profile")
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Profile"
        return label
    }()

    private lazy var stackView: UIStackView = {
        let arrangeSubViews = [
            iconImageView,
            titleLabel,
            UIView(),
        ]
        let stackView = UIStackView(arrangedSubviews: arrangeSubViews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 12, bottom: 12, right: 12)
        return stackView
    }()

    // MARK: Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup uiviews in UIViewController

    private func setupViews() {
        addSubview(stackView)
    }

    // MARK: Layout UIViews...

    private func setupLayout() {
        stackView.fullScreenEdge()
    }
}
