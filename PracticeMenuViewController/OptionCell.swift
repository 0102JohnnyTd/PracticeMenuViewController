//
//  ShowFormCell.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import UIKit

final class OptionCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!

    func configure(row: Int, titleArray: [String]) {
        titleLabel.text = titleArray[row]
    }
}
