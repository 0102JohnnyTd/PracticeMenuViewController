//
//  CellManager.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import Foundation

enum CellManager: Int, CaseIterable {
    case ShowFormCell
    case ShowReviewPageCell

    var cellIndetifier: String {
        switch self {
        case .ShowFormCell:
            return "ShowFormCellID"
        case .ShowReviewPageCell:
            return "ShowReviewPageCellID"
        }
    }
}
