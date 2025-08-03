//
//  QuizCategoryView.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import SwiftUI

struct QuizCategoryView: View {
    let onSelect: (Route) -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("クイズの種類を選択")
                .font(.title2)

            Button("文法クイズ") {
                onSelect(.grammarQuizSettings)
            }

            Button("格変化クイズ") {
                onSelect(.caseQuiz)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("クイズカテゴリ")
    }
}


