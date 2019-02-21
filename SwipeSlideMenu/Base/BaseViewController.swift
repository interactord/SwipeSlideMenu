////
////  BaseViewController.swift
////  SwipeSlideMenu
////
////  Created by SANGBONG MOON on 21/02/2019.
////  Copyright © 2019 Scott Moon. All rights reserved.
////
//
//import UIKit
//import RxCocoa
//import RxSwift
//
//class BaseViewController: UIViewController {
//
//    let bag = DisposeBag()
//    let viewModel: ViewModelType
//
//    init(viewModel: ViewModelType) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        setupViews()
//        setupLayout()
//        binding(viewModel: viewModel)
//    }
//
//    func setupViews() { }
//
//    func setupLayout() { }
//
//    func setBinding(viewModel: ViewModelType) {
//
//    }
//
//}
