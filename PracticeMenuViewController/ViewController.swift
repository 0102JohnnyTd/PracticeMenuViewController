//
//  ViewController.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import UIKit
import SafariServices

private enum CellIDManager {
    static let showFormCellID = "ShowFormCellID"
    static let showReviewPageCellID = "ShowReviewPageCellID"
}

private enum NibNameManager {
    static let showFormNib = "showFormCell"
    static let showReviewPageNib = "showReviewPageCell"
}

class ViewController: UIViewController {
    @IBOutlet weak var menuTableView: UITableView! {
        didSet {
            regiserCells()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }

    func regiserCells() {
        menuTableView.register(UINib(nibName: NibNameManager.showFormNib, bundle: nil), forCellReuseIdentifier: CellIDManager.showFormCellID)
        menuTableView.register(UINib(nibName: NibNameManager.showReviewPageNib, bundle: nil), forCellReuseIdentifier: CellIDManager.showReviewPageCellID)
    }

    func showReviewPage() {
        let url = URL(string: "https://apps.apple.com/jp/app/apple-store/id375380948?mt=8&action=write-review")!
        UIApplication.shared.open(url)
    }

    func showFormPage() {
        let url = URL(string: "https://docs.google.com/forms/d/1xsQUm83KUc-mmiiLLbzR0Kq9S0jFrLWcy-DVSgJ0C-E/viewform?edit_requested=true")!
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellManager.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = CellManager(rawValue: indexPath.row)!

        switch cellType {
        case .showFormCell:
            return menuTableView.dequeueReusableCell(withIdentifier: CellIDManager.showFormCellID, for: indexPath) as! ShowFormCell
        case .showReviewPageCell:
            return menuTableView.dequeueReusableCell(withIdentifier: CellIDManager.showReviewPageCellID, for: indexPath) as! ShowReviewPageCell
        }

        // ↓発見したもう一つの実装コード
        // enumの方が保守性と可読性が高くdidSelectRowAtでも使用できるのでメリットが多いと判断した
//        let showFromCell = menuTableView.dequeueReusableCell(withIdentifier: CellIDManager.showFormCellID, for: indexPath) as! ShowFormCell
//
//        let showReviewPageCell = menuTableView.dequeueReusableCell(withIdentifier: CellIDManager.showReviewPageCellID, for: indexPath) as! ShowReviewPageCell
//
//        let cellArray = [showFromCell, showReviewPageCell]
//
//        return cellArray[indexPath.row]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuTableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case CellManager.showFormCell.rawValue:
            showFormPage()
        case CellManager.showReviewPageCell.rawValue:
            showReviewPage()
        default:
            break
        }
    }
}
