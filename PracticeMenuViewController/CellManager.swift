//
//  CellManager.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import Foundation

enum CellManager: Int, CaseIterable {
    case showFormCell
    case showReviewPageCell

    var cellIndetifier: String {
        switch self {
        case .showFormCell:
            return "ShowFormCellID"
        case .showReviewPageCell:
            return "ShowReviewPageCellID"
        }
    }
}
