//
//  MenuItemViewModel.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 19/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol MenuItemCellModelInput {
    init(icon: UIImage, title: String)
}

protocol MenuItemCellModelOutput {
    func configure(cell: MenuItemCell)
}

typealias MenuItemCellModelType = MenuItemCellModelInput & MenuItemCellModelOutput

class MenuItemCellModel: MenuItemCellModelType {

    private let icon: UIImage
    private let title: String

    required init(icon: UIImage, title: String) {
        self.icon = icon
        self.title = title
    }

    func configure(cell: MenuItemCell) {
        cell.iconImageView.image = icon
        cell.titleLabel.text = title
    }

}
