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

class MenuViewController: UIViewController {

    // MARK: Definition Variable

    var bag: DisposeBag?

    var viewModel: MenuViewModelType? {
        didSet {
            guard let viewModel = viewModel else { return }

            let bag = DisposeBag()

            tableView.rx.setDelegate(self).disposed(by: bag)

            viewWillAppearTrigger
                .bind(to: viewModel.startAction)
                .disposed(by: bag)

            viewModel
                .menuItems
                .bind(to: self.tableView.rx.items(dataSource: source))
                .disposed(by: bag)

            self.bag = bag
        }
    }

    private let cellId = "cellId"

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
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

    private lazy var menuItems = [
        MenuItem(icon: #imageLiteral(resourceName: "profile"), title: "Profile"),
        MenuItem(icon: #imageLiteral(resourceName: "lists"), title: "Lists"),
        MenuItem(icon: #imageLiteral(resourceName: "bookmark"), title: "Bookmarks"),
        MenuItem(icon: #imageLiteral(resourceName: "moments"), title: "Moments"),
    ]

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    // MARK: Setup uiviews in UIViewController

    private func setupViews() {
        view.addSubview(tableView)
    }

    // MARK: Layout UIViews...

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(self.view)
        }
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
