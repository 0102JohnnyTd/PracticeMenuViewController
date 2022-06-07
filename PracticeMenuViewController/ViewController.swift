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
    static let showReviewPageNib = "showReviewPage"
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
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        menuTableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! ShowFormCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuTableView.deselectRow(at: indexPath, animated: true)
        let url = "https://docs.google.com/forms/d/1xsQUm83KUc-mmiiLLbzR0Kq9S0jFrLWcy-DVSgJ0C-E/viewform?edit_requested=true"
        let safariVC = SFSafariViewController(url: NSURL(string: url)! as URL)
        present(safariVC, animated: true, completion: nil)
    }
}
