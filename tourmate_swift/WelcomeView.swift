//
//  WelcomeView.swift
//  tourmate_swift
//
//  Created by gakutohiguchi on 2023/05/19.
//

import SwiftUI

struct Welcomeview: View {
    //    @State private var path: [Route] = []
    @EnvironmentObject var appEnvironment: AppEnvironment
    var body: some View {
        
        NavigationStack(path: $appEnvironment.path) {
            VStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("TourMate")
                        .font(.system(size: 72, weight: .bold, design: .default))
                        .italic()
                        .foregroundColor(.white)
                        .padding(.leading, 6)
                }
                .frame(maxWidth: .infinity, maxHeight: 370, alignment: .bottomLeading)
                .background(Color.purpleCustom)
                
                Spacer()
                    .frame(height: 70)
                
                //                    Button {
                //                        path = [
                //                            Route.SignUp]
                //                    } label: {
                //                        Text("メールアドレスで登録する")
                //                            .font(.system(size: 20, weight: .bold))
                //                            .foregroundColor(.white)
                //                    }
                //                    .padding(7)
                //                    .background(Color.pinkCustom)
                //                    .cornerRadius(20)
                //                    .navigationDestination(for: Route.self) { Route in
                //                        switch Route {
                //                        case .SignUp:
                //                            SignUpView()
                //                        case .Welcome:
                //                            Welcomeview()
                //                        }
                //                    }
                Button{
                    appEnvironment.path.append(Route.SignUp)
                }label: {
                    Text("メールアドレスで登録する")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(13)
                .background(Color.pinkCustom)
                .cornerRadius(20)
                .navigationDestination(for: Route.self) { Route in
                    switch Route {
                    case .SignUp:
                        SignUpView()
                    case .UserName:
                        UserNameView()
                    case .Welcome:
                        Welcomeview()
                    case .ProfileImage:
                        ProfileImageView()
                    }
                }
                LoginContainer() // ダミーのビュー
                    .padding(.bottom, 160)
                
                Button(action: {}) {
                    Text("利用することで利用規約・プライバシーポリシーに同意したものとします。")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                }
                .frame(width: 225, height: 160, alignment: .bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.purpleCustom)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct LoginContainer: View { // ダミーのビュー
    var body: some View {
        Text("ログイン")
            .fontWeight(.bold)
            .padding(10)
    }
}
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Welcomeview()
            .environmentObject(AppEnvironment())
    }
}
