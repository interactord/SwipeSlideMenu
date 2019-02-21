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

class MenuViewModel: ViewModelType {

    // MARK: Input
    struct InputType {
        let start: PublishSubject<Void>
    }

    // MARK: Output
    struct OutputType {
        let menuItems: Observable<[MenuSection]>
    }

    let input: InputType
    var output: OutputType
    init() {
        self.input = MenuViewModel.setInputType()
        self.output = MenuViewModel.setOupType(input: input)
    }

    static func setInputType() -> InputType {
        let start = PublishSubject<Void>()
        return InputType(start: start)
    }

    static func setOupType(input: InputType) -> OutputType {
        let menuItems = input.start
            .map { print("menuItems") }
            .map { (_) -> [MenuSection] in
                let items = [
                    MenuItemCellModel(icon: #imageLiteral(resourceName: "profile"), title: "Home"),
                    MenuItemCellModel(icon: #imageLiteral(resourceName: "lists"), title: "Lists"),
                    MenuItemCellModel(icon: #imageLiteral(resourceName: "bookmark"), title: "Bookmarks"),
                    MenuItemCellModel(icon: #imageLiteral(resourceName: "moments"), title: "Moments"),
                    ]

                return [SectionModel(model: Void(), items: items)]
        }
        return OutputType(menuItems: menuItems)
    }
}
