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

    var filteredResult = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        filteredResult = chatroomGroups

        tableView.backgroundColor = .purple
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "UNREAD" : section == 1 ? "ChANNELS" : "DIRECT MESSAGES"
    }

    fileprivate class ChatroomHeaderLabel: UILabel {
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.insetBy(dx: 16, dy: 0))

        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let text = section == 0 ? "UNREAD" : section == 1 ? "ChANNELS" : "DIRECT MESSAGES"

        let lable = ChatroomHeaderLabel()
        lable.text = text
        lable.textColor = #colorLiteral(red: 0.4745098039, green: 0.4078431373, blue: 0.4666666667, alpha: 1)
        return lable
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredResult.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResult[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatroomMenuCell(style: .default, reuseIdentifier: nil)

        // so what is the text to fill out?

        let text = filteredResult[indexPath.section][indexPath.item]

        cell.textLabel?.text = text
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        let attributedText = NSMutableAttributedString(
            string: "#  ",
            attributes: [
                    .foregroundColor: #colorLiteral(red: 0.4745098039, green: 0.4078431373, blue: 0.4666666667, alpha: 1),
                    .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            ]
        )
        attributedText.append(NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.white]))

        cell.textLabel?.attributedText = attributedText
        return cell
    }

    func seachFilteredResult(seachText: String) {

        if seachText.isEmpty {
            filteredResult = chatroomGroups
            tableView.reloadData()
            return
        }

        filteredResult = chatroomGroups.map { group in
            return group.filter { $0.lowercased().contains(seachText.lowercased()) }
        }

        tableView.reloadData()
    }
}
