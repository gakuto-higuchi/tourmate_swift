//
//  ProfileImageView.swift
//  tourmate_swift
//
//  Created by gakutohiguchi on 2023/05/24.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import UIKit

struct ProfileImageView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var image: UIImage? = nil
    @State private var showImagePicker = false
    @State private var infoText: String = ""
    
    var body: some View {
        ZStack {
            Color.purpleCustom.ignoresSafeArea()
            VStack {
                Spacer().frame(height: 200)
                Text("あなたのアイコンは？")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer().frame(height: 50)
                VStack {
                    if let img = image {
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fill) // Add this line
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .padding(.bottom, 20)
                    } else {
                        Button(action: {
                            showImagePicker = true
                        }) {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }.padding(.bottom, 20)
                    }
                    Text(infoText).padding(.all, 8)
                }.padding(.horizontal,20)
                Spacer().frame(height: 50)
                Button(action: uploadImage) {
                    Text("次へ")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 100,height: 60)
                        .background(Color.pinkCustom)
                        .cornerRadius(15)
                }.padding(.horizontal)
                    .padding(.bottom, 50)
                Spacer()
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(image: $image, sourceType: .photoLibrary)
        }
    }
    
    private func uploadImage() {
        guard let img = image, let data = img.jpegData(compressionQuality: 1.0) else {
            infoText = "画像を選択してください"
            return
        }
        
        guard let user = Auth.auth().currentUser else {
            infoText = "ユーザログインできていません"
            return
        }
        
        let storageRef = Storage.storage().reference().child("users/\(user.uid)/profile_image")
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                infoText = "アイコンの変更に失敗しました: \(error)"
            } else {
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        infoText = "アイコンの変更に失敗しました: \(error?.localizedDescription ?? "")"
                        return
                    }
                    let db = Firestore.firestore()
                    db.collection("users").document(user.uid).setData([
                        "profile_image": downloadURL.absoluteString
                    ], merge: true) { error in
                        if let error = error {
                            infoText = "アイコンの変更に失敗しました: \(error)"
                        } else {
                            infoText = "アイコンを変更しました"
                            // Navigate to the next screen
                        }
                    }
                }
            }
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView()
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    let sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

