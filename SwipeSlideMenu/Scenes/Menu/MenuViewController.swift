//
//  MenuViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 17/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

struct MenuItem {
    let icon: UIImage
    let title: String
}

class MenuViewController: BaseViewController {

    // MARK: Definition Variable

    var viewModel: MenuViewModel!

    private let cellId = "cellId"

    private lazy var baseView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rx.setDelegate(self).disposed(by: bag)
        tableView.dataSource = nil
        tableView.separatorStyle = .none
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()

    lazy var source = RxTableViewSectionedReloadDataSource<MenuSection>(configureCell: configureCell)

    lazy var configureCell: RxTableViewSectionedReloadDataSource<MenuSection>.ConfigureCell = { [weak self] _, tableView, indexPath, viewModel in

        guard
            let strongSelf = self,
            let cell = tableView.dequeueReusableCell(withIdentifier: strongSelf.cellId),
            let menuCell = cell as? MenuItemCell
            else { return UITableViewCell() }

        viewModel.configure(cell: menuCell)
        return menuCell
    }

    // MARK: Life cycle

    override func setupView() {
        super.setupView()
        view.addSubview(baseView)

    }

    override func setupContraints() {
        super.setupContraints()

        baseView.fullScreenEdge()
    }

    override func setupBindingInput() {
        super.setupBindingInput()

        viewWillAppearTrigger
            .bind(to: viewModel.input.start)
            .disposed(by: bag)
    }

    override func setupBindingOutput() {
        super.setupBindingOutput()

        viewModel
            .output
            .menuItems
            .bind(to: self.baseView.rx.items(dataSource: source))
            .disposed(by: bag)

        baseView
            .rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                let masterViewController = UIApplication.shared.keyWindow?.rootViewController as? MasterViewController
                masterViewController?.didSelectMenuItem(indexPath: indexPath)
            }).disposed(by: bag)
    }

}

// MARK: UITableView DataSource

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customMenuHeaderView = CustomMenuHeaderView()
        return customMenuHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}
