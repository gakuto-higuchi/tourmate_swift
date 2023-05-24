//
//  UserNameView.swift
//  tourmate_swift
//
//  Created by gakutohiguchi on 2023/05/22.
//

import SwiftUI

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct UserNameView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var infoText: String = ""
    @State private var userName: String = ""
    @State private var email: String = ""

    var body: some View {
        ZStack {
            Color.purpleCustom.ignoresSafeArea()
            VStack {
                Spacer().frame(height: 200)
                Text("あなたのなまえは？")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer().frame(height: 50)
                VStack {
                    TextField("ユーザーネーム", text: $userName)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10.0)
                        .padding(.bottom, 20)
                    Text(infoText).padding(.all, 8)
                }.padding(.horizontal,20)
                Spacer().frame(height: 50)
                Button(action: saveUserName) {
                    Text("次へ")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 100,height: 60)
                        .background(Color.pinkCustom)
                        .cornerRadius(15)
                }.padding(.horizontal)
                Spacer()
            }
        }
    }

    private func saveUserName() {
        guard let user = Auth.auth().currentUser else {return}
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).setData([
            "user_name": userName,
            "time": Date()
        ]) { err in
            if let err = err {
                infoText = "Error writing document: \(err)"
            } else {
                // Navigate to the next screen
                DispatchQueue.main.async {
                    appEnvironment.path.append(Route.ProfileImage)
                }
            }
        }
    }
}

struct UserNameView_Previews: PreviewProvider {
    static var previews: some View {
        UserNameView()
            .environmentObject(AppEnvironment())
    }
}
