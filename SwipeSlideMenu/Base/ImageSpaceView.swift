//
//  ImageSpaceView.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 19/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class ImageSpaceView: UIImageView {

    var space: CGFloat

    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }

    override var intrinsicContentSize: CGSize {
        return .init(width: space, height: space)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
