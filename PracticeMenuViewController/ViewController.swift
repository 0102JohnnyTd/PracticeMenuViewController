//
//  ViewController.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    private let nib = "showFormCell"

    @IBOutlet weak var menuTableView: UITableView! {
        didSet {
            menuTableView.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: "CellID")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
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
