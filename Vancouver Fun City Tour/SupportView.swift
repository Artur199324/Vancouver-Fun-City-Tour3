import SwiftUI

struct SupportScreen: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var email = ""
    @State private var message = ""
    @Environment(\.dismiss) private var dismiss
    @State private var showConfirmationDialog = false
    @State private var set = false
    
    var body: some View {
        ZStack {
         
            Image("launch")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 20) {
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("Support")
                        .font(.headline)
                        .foregroundColor(.white)

                    Spacer()

                    Button(action: {
                        set.toggle()
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 70)
                Button(action: {
                    showImagePicker = true
                }) {
                    ZStack {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .cornerRadius(12)
                                .clipped()
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.4))
                                .frame(height: 200)
                                .overlay(
                                    VStack {
                                        Image(systemName: "paperclip")
                                            .font(.title)
                                            .foregroundColor(.white)
                                        Text("Attach File / Image")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                )
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $selectedImage)
                }

               
                ZStack(alignment: .leading) {
                    if email.isEmpty {
                        Text("Your Email")
                            .foregroundColor(.gray)
                            .padding(.leading, 15)
                    }
                    TextField("", text: $email)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black.opacity(0.4), lineWidth: 1)
                        )
                }
                .padding(.horizontal)

      
                ZStack(alignment: .topLeading) {
                    if message.isEmpty {
                        Text("Your Message")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 15)
                    }
                    TextEditor(text: $message)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black.opacity(0.4), lineWidth: 1)
                        )
                        .frame(height: 150)
                        .scrollContentBackground(.hidden)
                }
                .padding(.horizontal)

           
                Button(action: {
                    showConfirmationDialog = true
                }) {
                    Text("Send Message")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("tit1"))
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .alert(isPresented: $showConfirmationDialog) {
                    Alert(
                        title: Text("Message Sent"),
                        message: Text("Your message has been successfully sent."),
                        dismissButton: .default(Text("OK"))
                    )
                }

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $set) {
            SettingsScreen()
        }
    }
}

#Preview {
    SupportScreen()
}
