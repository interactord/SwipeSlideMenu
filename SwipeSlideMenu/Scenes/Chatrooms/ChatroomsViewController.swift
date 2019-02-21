//
//  ChatroomsMenuController.swift
//  SildeMenu
//
//  Created by SANGBONG MOON on 22/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class ChatroomsMenuController: UITableViewController {

    let chatroomGroups = [
        ["general", "interoductions"],
        ["jobs"],
        ["Scott", "Brick", "Pinpong", "Sean"],
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .purple
        tableView.separatorStyle = .none

        tableView.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "UNREAD" : section == 1 ? "ChANNELS" : "DIRECT MESSAGES"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatroomGroups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatroomGroups[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        // so what is the text to fill out?

        let text = chatroomGroups[indexPath.section][indexPath.item]

        cell.textLabel?.text = text
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return cell
    }
}
