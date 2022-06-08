//
//  CellManager.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/07.
//

import Foundation

enum CellManager: Int, CaseIterable {
    case formPageCell
    case reviewPageCell

    var cellIndetifier: String {
        switch self {
        case .formPageCell:
            return "FormPageCellID"
        case .reviewPageCell:
            return "ReviewPageCellID"
        }
    }
}
