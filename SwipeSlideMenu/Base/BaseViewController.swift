//
//  BaseViewController.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 18/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var redViewLeadingConstaint: NSLayoutConstraint!
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
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
        ])

        redViewLeadingConstaint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstaint.isActive = true
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

        redViewLeadingConstaint.constant = translationX
    }

}
