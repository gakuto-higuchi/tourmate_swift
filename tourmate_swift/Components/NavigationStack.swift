//
//  NavigationStack.swift
//  tourmate_swift
//
//  Created by gakutohiguchi on 2023/05/20.
//

import SwiftUI
// 画面遷移のデータを管理
class AppEnvironment: ObservableObject {
    @Published var signUppath: [Route] = []
}

enum Route: Hashable {
    case welcome
    case signUp
}

struct NavigationModifier: ViewModifier {
    @Binding var path: [Route]

    @ViewBuilder
    fileprivate func coordinator(_ route: Route) -> some View {
        switch route {
        case .welcome:
            Welcomeview()
        case .signUp:
            SignUpView()
        }
    }

    func body(content: Content) -> some View {
        NavigationStack(path: $path) {
            content
                .navigationDestination(for: Route.self) { route in
                    coordinator(route)
                }
        }
    }
}
extension View {
    func navigation(path: Binding<[Route]>) -> some View {
        self.modifier(NavigationModifier(path: path))
    }
}
