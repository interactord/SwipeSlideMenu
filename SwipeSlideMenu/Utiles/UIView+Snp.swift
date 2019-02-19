//
//  UIView+Snp.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 20/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    func fullScreenEdge(size: Double? = 0) {
        self.snp.makeConstraints { make in
            make.edges.equalTo(size ?? 0)
        }
    }

    func fullScreenAnchor(parentView: UIView, offset: Double? = 0) {
        self.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(parentView).offset(offset ?? 0)
        }
    }
}
