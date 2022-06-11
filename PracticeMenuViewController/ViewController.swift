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

    private var cellNumber = 0

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

    func setUpCustomSection(section: Int) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .systemGray6
        headerView.frame = CGRect(x: 0, y: 0, width: menuTableView.frame.width, height: menuTableView.frame.width * 1/2)

        let titleLabel = UILabel()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        titleLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        titleLabel.sizeToFit()

//        コンパクトな書き方
//        titleLabel.text = headerTitle[section]
        let sectionType = SectionManager(rawValue: section)
        switch sectionType {
        case .supportSection:
            titleLabel.text = sectionType?.sectionTitle
        case .assesmentSection:
            titleLabel.text = sectionType?.sectionTitle
        case .generalSection:
            titleLabel.text = sectionType?.sectionTitle
        case .none:
            break
        }

        headerView.addSubview(titleLabel)
        return headerView
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionManager.allCases.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        setUpCustomSection(section: section)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = SectionManager(rawValue: section)

        switch sectionType {
        case .supportSection:
            return 1
        case .assesmentSection:
            return 2
        case .generalSection:
            return 0
        case .none:
            return 0
        }
//        CellManager.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = CellManager(rawValue: cellNumber)!
        cellNumber += 1

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
        case CellManager.uiActivityVCCell.rawValue:
            showUIActivityVC()
        default:
            break
        }
    }
}
