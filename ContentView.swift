//
//  ContentView.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import SwiftUI
import SwiftData

enum Route: Hashable {
    case learningSetting
    case vocabCard(limit: Int, level: String)
    case result(correctCount: Int, totalCount: Int)
    case quizCategory
    case grammarQuizSettings
    case grammarQuiz(limit: Int)
    case caseQuiz
    case grammarQuizResult(correctCount: Int, totalCount: Int)
}

struct ContentView: View {
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 24) {
                Text("ドイツ語学習アプリ")
                    .font(.title)

                Button("単語学習設定へ") {
                    path.append(.learningSetting)
                }

                Button("クイズへ") {
                    path.append(.quizCategory)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .learningSetting:
                    LearningSettingView { count, level in
                        path.append(.vocabCard(limit: count, level: level))
                    }

                case let .vocabCard(limit, level):
                    VocabCardView(
                        limit: limit,
                        level: level,
                        onFinish: { correct, total in
                            path.append(.result(correctCount: correct, totalCount: total))
                        },
                        onBackToSetting: {
                            path = [.learningSetting]
                        }
                    )

                case let .result(correctCount, totalCount):
                    ResultView(correctCount: correctCount, totalCount: totalCount) {
                        path = [.learningSetting]
                    }

                case .quizCategory:
                    QuizCategoryView { selected in
                        if selected == .grammarQuizSettings {
                            path.append(.grammarQuizSettings)
                        } else {
                            path.append(selected)
                        }
                    }

                case .grammarQuizSettings:
                    GrammarQuizSettingsView { limit in
                        path.append(.grammarQuiz(limit: limit))
                    }

                case let .grammarQuiz(limit):
                    GrammarMultipleChoiceQuizView(limit: limit) { correct, total in
                        // クイズ終了後の遷移処理例（結果画面へ）
                        path.append(.grammarQuizResult(correctCount: correct, totalCount: total))
                    }
                
                case let .grammarQuizResult(correctCount, totalCount):
                        GrammarResultView(correctCount: correctCount, totalCount: totalCount) {
                            path = [.grammarQuizSettings]
                        }


                case .caseQuiz:
                    CaseQuizView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
