//
//  ViewController.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import UIKit
import SafariServices

private enum CellIDManager {
    static let formPageCellID = "FormPageCellID"
    static let reviewPageCellID = "ReviewPageCellID"
    static let uiActivityVCCellID = "UIActivityViewControllerCellID"
}

private enum NibNameManager {
    static let formPageNib = "FormPageCell"
    static let reviewPageNib = "ReviewPageCell"
    static let uiActivityVCNib = "UIActivityViewControllerCell"
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
        menuTableView.register(UINib(nibName: NibNameManager.formPageNib, bundle: nil), forCellReuseIdentifier: CellIDManager.formPageCellID)
        menuTableView.register(UINib(nibName: NibNameManager.reviewPageNib, bundle: nil), forCellReuseIdentifier: CellIDManager.reviewPageCellID)
        menuTableView.register(UINib(nibName: NibNameManager.uiActivityVCNib, bundle: nil), forCellReuseIdentifier: CellIDManager.uiActivityVCCellID)
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

    func showUIActivityVC() {
        let activityVC = UIActivityViewController(activityItems: ["メッセージを入力してください"], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellManager.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = CellManager(rawValue: indexPath.row)!

        switch cellType {
        case .formPageCell:
            return menuTableView.dequeueReusableCell(withIdentifier: cellType.cellIndetifier, for: indexPath) as! FormPageCell
        case .reviewPageCell:
            return menuTableView.dequeueReusableCell(withIdentifier: cellType.cellIndetifier, for: indexPath) as! ReviewPageCell
        case .uiActivityVCCell:
            return menuTableView.dequeueReusableCell(withIdentifier: cellType.cellIndetifier, for: indexPath) as! UIActivityViewControllerCell
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
        case CellManager.formPageCell.rawValue:
            showFormPage()
        case CellManager.reviewPageCell.rawValue:
            showReviewPage()
        default:
            break
        }
    }
}
