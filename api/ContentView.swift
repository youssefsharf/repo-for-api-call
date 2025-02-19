import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var showUserInfo: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    TextField("Enter GitHub username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        showUserInfo = true
                    }) {
                        Text("Search")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    if showUserInfo {
                        Api(username: username)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("GitHub User Search")
        }
    }
}
