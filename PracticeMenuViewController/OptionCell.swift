//
//  ShowFormCell.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import UIKit

class OptionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    func configure(row: Int, titleArray: [String]) {
        titleLabel.text = titleArray[row]
    }
}
