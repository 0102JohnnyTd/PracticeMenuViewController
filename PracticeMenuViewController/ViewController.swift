//
//  ViewController.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import UIKit

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
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        menuTableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! ShowFormCell
    }
}
