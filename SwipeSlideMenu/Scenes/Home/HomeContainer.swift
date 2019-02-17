//
//  BaseContainer.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 17/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Swinject

final class HomeContainer {

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

        container.register(BaseViewController.self) { _ in
            let viewController = BaseViewController()
            return viewController
        }
    }

    func getViewController() -> HomeViewController {
        let viewController = container.resolve(HomeViewController.self)!
        return viewController
    }

    func getBaseViewController() -> BaseViewController {
        let viewController = container.resolve(BaseViewController.self)!
        return viewController
    }
}

extension HomeContainer: BaseContainter {
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
