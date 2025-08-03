//
//  GrammarQuizSettingsView.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import SwiftUI

import SwiftUI

struct GrammarQuizSettingsView: View {
    let onStart: (Int) -> Void

    @State private var selectedCount = 10
    let countOptions = [5, 10, 20]

    var body: some View {
        VStack(spacing: 24) {
            Text("文法クイズ問題数選択")
                .font(.title2)

            Picker("問題数", selection: $selectedCount) {
                ForEach(countOptions, id: \.self) { count in
                    Text("\(count)問").tag(count)
                }
            }
            .pickerStyle(.segmented)

            Button("クイズ開始") {
                onStart(selectedCount)
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
        .navigationTitle("文法クイズ設定")
    }
}

#Preview {
    GrammarQuizSettingsView { _ in }
}

