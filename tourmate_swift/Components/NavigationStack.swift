//
//  NavigationStack.swift
//  tourmate_swift
//
//  Created by gakutohiguchi on 2023/05/20.
//

import SwiftUI
// 画面遷移のデータを管理

enum Route: Hashable {
    case Welcome
    case SignUp
    case UserName
}

//class AppEnvironment: ObservableObject {
//    @Published var path: NavigationPath = NavigationPath()
//}

class AppEnvironment: ObservableObject {
    @Published var path: [Route] = []

}
