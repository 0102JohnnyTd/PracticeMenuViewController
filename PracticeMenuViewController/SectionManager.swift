//
//  SectionManager.swift
//  PracticeMenuViewController
//
//  Created by Johnny Toda on 2022/06/09.
//

import Foundation


enum SectionManager: Int, CaseIterable {
    case supportSection
    case assesmentSection
    case generalSection

    var sectionTitle: String {
        switch self {
        case .supportSection:
            return "Support"
        case .assesmentSection:
            return "Assesment"
        case .generalSection:
            return "General"
        }
    }
}
