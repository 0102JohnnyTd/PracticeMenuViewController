//
//  ViewController.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import UIKit
import SafariServices

private enum URLManager {
    static let formPageURL = "https://docs.google.com/forms/d/1xsQUm83KUc-mmiiLLbzR0Kq9S0jFrLWcy-DVSgJ0C-E/viewform"
    static let reviewPageURL = "https://apps.apple.com/jp/app/apple-store/id375380948?mt=8&action=write-review"
}

final class ViewController: UIViewController {
    @IBOutlet private weak var menuTableView: UITableView! {
        didSet {
            menuTableView.sectionFooterHeight = 0
            regiserCells()
        }
    }

    private let nib = "OptionCell"
    private let cellIdentifier = "CellID"
    private let sectionArray = ["Support", "Assesment", "General"]
    private let supportSectionCellTitle = ["お問い合わせ"]
    private let assesmentSectionCellTitle = ["アプリを評価する", "アプリを友達に教える"]


    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }

    private func regiserCells() {
        menuTableView.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    private func setUpCustomSection(section: Int) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .gray

        let titleLabel = UILabel()
        titleLabel.textColor = .white
        headerView.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
        titleLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        titleLabel.sizeToFit()

        titleLabel.text = sectionArray[section]
        return headerView
    }

    private func showFormPage() {
        let url = URL(string: URLManager.formPageURL)!
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }

    private func showReviewPage() {
        let url = URL(string: URLManager.reviewPageURL)!
        UIApplication.shared.open(url)
    }

    private func showUIActivityVC() {
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
            return SupportSectionCell.allCases.count
        case .assesmentSection:
            return AssesmentSectionCell.allCases.count
        case .generalSection:
            return 0
        case .none:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! OptionCell

        let sectionType = SectionManager(rawValue: indexPath.section)
        switch sectionType {
        case .supportSection:
            cell.configure(row: indexPath.row, titleArray: supportSectionCellTitle)

        case .assesmentSection:
            cell.configure(row: indexPath.row, titleArray: assesmentSectionCellTitle)

        case .generalSection:
            break

        case .none:
            break
        }

        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuTableView.deselectRow(at: indexPath, animated: true)

        let sectionType = SectionManager(rawValue: indexPath.section)

        switch sectionType {
        case .supportSection:
            let supportSectionCell = SupportSectionCell(rawValue: indexPath.row)

            switch supportSectionCell {
            case .formPageCell:
                showFormPage()
            case .none:
                break
            }

        case .assesmentSection:
            let assesmentSectionCell = AssesmentSectionCell(rawValue: indexPath.row)

            switch  assesmentSectionCell {
            case .reviewPageCell:
                showReviewPage()
            case .uiActivityVCCell:
                showUIActivityVC()
            case .none:
                break
            }

        case .generalSection:
            break

        case .none:
            break
        }
    }
}
