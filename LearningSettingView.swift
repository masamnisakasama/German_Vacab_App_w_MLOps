//
//  LearningSettingView.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import SwiftUI

struct LearningSettingView: View {
    let onStart: (Int, String) -> Void

    @State private var selectedCount = 10
    @State private var selectedLevel = "A1"

    let countOptions = [5, 10, 20]
    let levelOptions = ["A1", "A2", "B1", "B2", "C1", "C2"]

    var body: some View {
        VStack(spacing: 24) {
            Text("学習単語の設定")
                .font(.title2)

            Picker("レベル", selection: $selectedLevel) {
                ForEach(levelOptions, id: \.self) { level in
                    Text(level)
                }
            }
            .pickerStyle(.segmented)

            Picker("単語数", selection: $selectedCount) {
                ForEach(countOptions, id: \.self) { count in
                    Text("\(count)")
                }
            }
            .pickerStyle(.segmented)

            Button("学習を始める") {
                onStart(selectedCount, selectedLevel)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("単語学習設定")
    }
}

#Preview {
    LearningSettingView(onStart: { count, level in
        print("開始: \(count)語, レベル: \(level)")
    })
}
