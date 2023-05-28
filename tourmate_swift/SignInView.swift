//
//  SignInView.swift
//  tourmate_swift
//
//  Created by gakutohiguchi on 2023/05/29.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var infoText: String = ""

    var body: some View {
        VStack {
            Text("ログインする？")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 120)
            VStack{
                TextField("メールアドレス", text: $email)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10.0)
                    .padding(.bottom, 20)
                SecureField("パスワード", text: $password)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10.0)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal, 25)
            if !infoText.isEmpty {
                Text(infoText)
                    .foregroundColor(.red)
            }
            HStack{
                Button {
                    appEnvironment.path.removeLast()
                } label: {
                    Text("戻る")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 100,height: 60)
                        .background(Color.pinkCustom)
                        .cornerRadius(15)
                }
                Spacer()
                Button(action: signIn) {
                    Text("次へ")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 100,height: 60)
                        .background(Color.pinkCustom)
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 130)
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purpleCustom)
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.infoText = "ログインに失敗しました: \(e.localizedDescription)"
            } else {
                DispatchQueue.main.async {
                    appEnvironment.path.append(Route.Home)
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AppEnvironment())
    }
}
