//
//  BaseContainer.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 17/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Swinject

protocol BaseContainter {
    func getChild() -> Container
    func resolve<Service>(serviceType: Service.Type) -> Service?
    func resolve<Service>(serviceType: Service.Type, name: String) -> Service?
}
