//
//  MenuViewModel.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 19/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

typealias MenuSection = SectionModel<Void, MenuItemCellModelType>

protocol MenuViewModelInput {
    var startAction: PublishSubject<Void> { get }
}

protocol MenuViewModelOutput {
    var menuItems: Observable<[MenuSection]> { get }
}

typealias MenuViewModelType = MenuViewModelInput & MenuViewModelOutput

class MenuViewModel: MenuViewModelType {

    // MARK: Input
    let startAction = PublishSubject<Void>()

    // MARK: Output
    var menuItems: Observable<[MenuSection]>

    init() {

        menuItems = startAction
            .map { print("menuItems") }
            .map { _ in
                let items = [
                    MenuItemCellModel(icon: #imageLiteral(resourceName: "profile"), title: "Home"),
                    MenuItemCellModel(icon: #imageLiteral(resourceName: "lists"), title: "Lists"),
                    MenuItemCellModel(icon: #imageLiteral(resourceName: "bookmark"), title: "Bookmarks"),
                    MenuItemCellModel(icon: #imageLiteral(resourceName: "moments"), title: "Moments"),
                ]

                return [SectionModel(model: Void(), items: items)]
            }
    }
}
