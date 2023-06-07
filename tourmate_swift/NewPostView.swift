import SwiftUI
import MapKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.images.append(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct PostMapView: UIViewRepresentable {
    @Binding var center: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Add a long press gesture recognizer
        let longPressRecognizer = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.mapLongPressed(gestureRecognizer:in:)))
        longPressRecognizer.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecognizer)

        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if let center = center {
            mapView.setCenter(center, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: PostMapView
        
        init(_ parent: PostMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
            if let annotationView = views.first {
                if let annotation = annotationView.annotation {
                    parent.center = annotation.coordinate
                }
            }
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation {
                parent.center = annotation.coordinate
            }
        }
        
        @objc func mapLongPressed(gestureRecognizer: UIGestureRecognizer, in mapView: MKMapView) {
            if gestureRecognizer.state == .began {
                let touchPoint = gestureRecognizer.location(in: mapView)
                let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                let annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinates
                DispatchQueue.main.async {
                    mapView.addAnnotation(annotation)
                }
            }
        }
    }
}

struct NewPostView: View {
    @State private var images = [UIImage]()
    @State private var showImagePicker = false
    @State private var comment = ""
    @State private var tags = ""
    @State private var centerCoordinate: CLLocationCoordinate2D?
    private let maxCommentLength = 200
    @FocusState private var focusedField: Field?
    enum Field: Hashable {
        case comment
        case tags
    }
    
    var body: some View {
        ZStack {
            Color.purpleCustom.edgesIgnoringSafeArea(.all)
                
                    ScrollView {
                        VStack {
                            if !images.isEmpty {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(images, id: \.self) { image in
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(10)
                                                .padding(5)
                                        }
                                    }
                                }
                                .padding()
                            }
                            
                            Button(action: {
                                showImagePicker = true
                            }) {
                                HStack {
                                    Image(systemName: "camera")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 20)
                                    Text("写真を選択")
                                        .fontWeight(.medium)
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                .padding(13)
                                .background(Color.pinkCustom)
                                .cornerRadius(20)
                            }
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(images: $images)
                            }
                            .padding()
                            
                            PostMapView(center: $centerCoordinate)
                                .frame(height: 200)
                                .cornerRadius(10)
                                .padding()
                            Text("タグ")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("タグ（#で区切ってね）例: #カフェ",text: $tags)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .focused($focusedField, equals: .tags)
                                .onTapGesture {
                                    focusedField = .tags
                                }
                                .padding([.leading, .bottom, .trailing])
                            Text("コメント")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("コメントを書く...", text: $comment, axis: .vertical)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .onChange(of: comment) { newValue in
                                    if newValue.count > maxCommentLength {
                                        comment = String(newValue.prefix(maxCommentLength))
                                    }
                                }
                                .focused($focusedField, equals: .comment)
                                .onTapGesture {
                                    focusedField = .comment
                                }
                                .padding([.leading, .bottom, .trailing])
                            
                            Button(action: {
                                // Handle post creation
                            }) {
                                Text("投稿")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.purpleCustom)
                                    .foregroundColor(.pinkCustom)
                                    .cornerRadius(10)
                            }
                            .padding([.leading, .trailing])
                        }
                        .padding([.top, .bottom], 10)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    focusedField = nil
                                }
                    }
                    
                }
        }
    }
    
    struct NewPostView_Previews: PreviewProvider {
        static var previews: some View {
            NewPostView()
        }
    }



