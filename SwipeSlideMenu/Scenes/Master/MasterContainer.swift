//
//  MasterContainer.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 20/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Swinject

final class MasterContainer {

    // MARK: Definition Variable
    var container: Container

    // MARK: Initializer
    init() {
        self.container = Container()
        register()
    }

    init?(container: Container) {
        self.container = container
        register()
    }

    func register() {

        container.register(HomeViewController.self) { _ in
            let viewController = HomeViewController()
            return viewController
        }

        container.register(MenuViewModelType.self) { _ in
            let viewModel = MenuViewModel()
            return viewModel
        }

        container.register(MenuViewController.self) { resolver in
            let viewController = MenuViewController()
            let viewModel = resolver.resolve(MenuViewModelType.self)!
            viewController.viewModel = viewModel
            return viewController
        }

        container.register(MasterViewController.self) { resolver in
            let masterViewController = MasterViewController()
            let homeViewController = resolver.resolve(HomeViewController.self)!
            let menuViewController = resolver.resolve(MenuViewController.self)!

            masterViewController.homeviewController = homeViewController
            masterViewController.menuViewController = menuViewController
            return masterViewController
        }
    }

    func getMasterViewController() -> MasterViewController {
        let viewController = container.resolve(MasterViewController.self)!
        return viewController
    }

    func getHomeViewController() -> HomeViewController {
        let viewController = container.resolve(HomeViewController.self)!
        return viewController
    }

    func getMenuViewController() -> MenuViewController {
        let viewController = container.resolve(MenuViewController.self)!
        return viewController
    }
}

extension MasterContainer: BaseContainter {
    func getChild() -> Container {
        return Container(parent: container)
    }

    func resolve<Service>(serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }

    func resolve<Service>(serviceType: Service.Type, name: String) -> Service? {
        return container.resolve(serviceType, name: name)
    }
}
