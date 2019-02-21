//
//  ChatroomMenuCell.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 22/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class ChatroomMenuCell: UITableViewCell {

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.6, blue: 0.5411764706, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        addSubview(bgView)
        // 4 constraints
        bgView.fillSuperview(padding: .init(top: 0, left: 8, bottom: 0, right: 8))
        sendSubviewToBack(bgView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        bgView.isHidden = !selected

        //        contentView.backgroundColor = selected ? .orange : .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
