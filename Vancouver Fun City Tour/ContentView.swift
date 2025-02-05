import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 0.0
    @State private var start = false
    @State private var auth = false
    @State private var menu = false
    @State private var percentage = 0
    @State private var showTermsWebView = false
    @State private var showPrivacyWebView = false

    var body: some View {
        VStack {
            Spacer()
            
           
            Image(start ? "314867927_dc264ab9-2ac8-43b0-a246-e03655b359a1 copy 1" : "352168373_a1399f15-7f92-453c-92df-3ba1ddeaed2d copy 1")
              
            
            if !start {
                ZStack(alignment: .leading) {
                    
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.white, lineWidth: 2)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                        )
                        .frame(height: 10)
                    
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.red)
                        .frame(width: progress * UIScreen.main.bounds.width * 0.8, height: 10)
                        .animation(.linear(duration: 5), value: progress)
                }
                .padding(.horizontal, 40)
                
                
                Text("\(percentage)%")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.top, 40)
                Spacer()
                HStack(spacing:30){
                    Button {
                        showTermsWebView.toggle()
                    } label: {
                        Text("Terms of Service")
                            .foregroundColor(.white)
                    }
                    Button {
                        showPrivacyWebView.toggle()
                    } label: {
                        Text("Privacy Policy")
                            .foregroundColor(.white)
                    }

                }.padding(.top,200)
                
                
            }else{
                VStack(spacing: 20) {
                       Text("VANCOUVER")
                           .font(.title)
                           .fontWeight(.bold)
                           .foregroundColor(.white)
                       
                       Text("FUN CITY TOUR")
                           .font(.title2)
                           .fontWeight(.bold)
                           .foregroundColor(.white)
                       
                       Text("Find the most popular and interesting\nplaces to visit, share your impressions\nwith your friends and have fun")
                           .multilineTextAlignment(.center)
                           .foregroundColor(.gray)
                           .padding(.horizontal, 20)
                       
                       Button(action: {
                           let isLoggedIn = LoginManager.shared.getLoginStatus()
                           if isLoggedIn{
                               menu.toggle()
                           }else{
                               auth.toggle()
                           }
                       }) {
                           Text("Continue")
                               .font(.headline)
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                               .padding()
                               .frame(maxWidth: .infinity)
                               .background(Color.orange)
                               .cornerRadius(10)
                       }
                       .padding(.horizontal, 40)
                   }
                   .padding()
                   .background(
                       RoundedRectangle(cornerRadius: 25)
                           .fill(Color.black.opacity(0.5))
                           .padding(.horizontal, 20)
                   )
            }
            
            Spacer()
        }
        .background(Image("launch").resizable().scaledToFill())
        .ignoresSafeArea()
        .onAppear {

            withAnimation {
                progress = 1.0
            }
            
          
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                if percentage < 100 {
                    percentage += 1
                } else {
                    timer.invalidate()
                    start = true
                }
            }
        }
        .fullScreenCover(isPresented: $auth) {
            AuthView()
        }
        .fullScreenCover(isPresented: $menu) {
            MainMenuView()
        }
        .sheet(isPresented: $showTermsWebView) {
            WebView(url: URL(string: "https://sites.google.com/view/captain-kitchen-of-flavo-trms/")!)
        }
        .sheet(isPresented: $showPrivacyWebView) {
            WebView(url: URL(string: "https://sites.google.com/view/captain-kitchen-of-flavor-priv/")!)
        }
    }
}

#Preview {
    ContentView()
}
