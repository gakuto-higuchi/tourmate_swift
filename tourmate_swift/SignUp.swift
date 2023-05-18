//
//  SignUp.swift
//  tourmate_swift
//
//  Created by gakutohiguchi on 2023/05/19.
//

import SwiftUI
import FirebaseAuth
struct SignUp: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var infoText: String = ""
    
    var body: some View {
        VStack() {
            Text("とうろくする？")
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
            .padding(.horizontal,25)
            HStack{
                
                Button(action: signUp) {
                    Text("戻る")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 100,height: 60)
                        .background(Color.pinkCustom)
                        .cornerRadius(15)
                    
                }
                Spacer()
                Button(action: signUp) {
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
            .padding(.bottom,130)
            
            if !infoText.isEmpty {
                Text(infoText)
                    .foregroundColor(.red)
                    .padding(.top, 20)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purpleCustom)
        
    }
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.infoText = "登録に失敗しました: \(e.localizedDescription)"
            } else {
                // Navigation code goes here
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
