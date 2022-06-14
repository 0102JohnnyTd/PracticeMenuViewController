//
//  ShowFormCell.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    private let titleArray = ["お問い合わせ", "アプリを評価する", "アプリを友達に教える"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(row: Int) {
        titleLabel.text = titleArray[row]
    }
}
