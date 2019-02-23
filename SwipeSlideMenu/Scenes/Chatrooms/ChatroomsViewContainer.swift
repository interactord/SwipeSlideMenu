//
//  ChatroomsViewContainer.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 23/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import SnapKit

class ChatroomsViewContainer: BaseViewController {

    private let chatroomsMenuController: ChatroomsMenuController
    private let seachViewContainer: SeachViewContainer

    init(chatroomsMenuController: ChatroomsMenuController, seachViewContainer: SeachViewContainer) {
        self.chatroomsMenuController = chatroomsMenuController
        self.seachViewContainer = seachViewContainer
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        super.setupView()

        view.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.2196078431, blue: 0.2862745098, alpha: 1)

        guard
            let chatroomsMenu = chatroomsMenuController.view,
            let seachView = seachViewContainer.view
            else { return }

        view.addSubview(chatroomsMenu)
        view.addSubview(seachView)
    }

    override func setupContraints() {
        super.setupContraints()

        guard
            let chatroomsMenu = chatroomsMenuController.view,
            let seachView = seachViewContainer.view
            else { return }

        seachView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(64)
        }

        chatroomsMenu.snp.makeConstraints { make in
            make.top.equalTo(seachView.snp.bottom)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.bottom.trailing.equalTo(self.view)
        }
    }
}
