//
//  BaseViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 18/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class BaseViewController: UIViewController {

    let bag = DisposeBag()

    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    var redViewLeadingOffset: CGFloat = 0
    var menuWith: CGFloat = 0
    private let menuWidth: CGFloat = 300

    override func viewDidLoad() {
        view.backgroundColor = .yellow

        setupViews()
        setupLayout()
        setupBinding()
    }

    func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
    }

    func setupLayout() {

        redView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(self.view)
        }

        blueView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.redView)
            make.trailing.equalTo(self.redView.snp.leading)
            make.width.equalTo(menuWidth)
        }

    }

    func setupBinding() {
        // how do we translate our red view
        let panGesture = view.rx.panGesture().share(replay: 1)

        panGesture
            .when(.changed)
            .asTranslation()
            .bind { self.panDragginMenu(translation: $0, velocity: $1) }
            .disposed(by: bag)

        panGesture
            .when(.ended)
            .asTranslation()
            .bind { self.panEndedMenu(translation: $0, velocity: $1) }
            .disposed(by: bag)
    }

    private func panDragginMenu(translation: CGPoint, velocity: CGPoint) {
        var translationX = translation.x

        translationX = min(menuWidth, translationX)
        translationX = max(0, translationX)

        redViewLeadingOffset = translationX
        redView.snp.updateConstraints { make in
            make.leading.equalTo(self.view).offset(redViewLeadingOffset)
        }
    }

    private func panEndedMenu(translation: CGPoint, velocity: CGPoint) {
        print("panEndedMenu")
    }

}
