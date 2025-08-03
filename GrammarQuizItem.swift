//
//  GrammarQuizItem.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import SwiftUI

struct GrammarQuizItem: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: String
    let category: String
}
