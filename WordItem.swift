//
//  WordItem.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import Foundation
import SwiftUI

struct WordItem: Identifiable {
    let id = UUID()
    let word: String
    let plural: String
    let meaning: String
    let example: String
    let exampleJa: String
    let note: String
    let category: String
}
