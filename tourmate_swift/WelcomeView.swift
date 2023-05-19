//
//  WelcomeView.swift
//  tourmate_swift
//
//  Created by gakutohiguchi on 2023/05/19.
//

import SwiftUI

struct Welcomeview: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Spacer()
                Text("TourMate")
                    .font(.system(size: 65, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.leading, 6)
            }
            .frame(maxWidth: .infinity, maxHeight: 370, alignment: .bottomLeading)
            .background(Color.purpleCustom)

            Spacer()
                .frame(height: 70)

            SigninContainer() // ダミーのビュー
                .padding(.bottom, 20)

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

struct SigninContainer: View { // ダミーのビュー
    var body: some View {
        Text("SigninContainer")
    }
}

struct LoginContainer: View { // ダミーのビュー
    var body: some View {
        Text("LoginContainer")
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Welcomeview()
    }
}
