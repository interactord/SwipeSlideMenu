//
//  BaseViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 18/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

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
        setupPanGesture()
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

    func setupPanGesture() {
        // how do we translate our red view
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }

    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var translationX = translation.x

        translationX = min(menuWidth, translationX)
        translationX = max(0, translationX)

        redViewLeadingOffset = translationX
        redView.snp.updateConstraints { make in
            make.leading.equalTo(self.view).offset(redViewLeadingOffset)
        }
    }

}
