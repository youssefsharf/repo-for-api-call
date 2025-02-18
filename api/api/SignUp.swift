import SwiftUI

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showMessage: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // إضافة النص Welcome أعلى الصفحة
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    signup(email: email, password: password)
                }) {
                    Text("Sign Up")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)

                if !showMessage.isEmpty {
                    Text(showMessage)
                        .padding()
                        .foregroundColor(showMessage.contains("success") ? .green : .red)
                }

                // إضافة النص "If you already have an account"
                HStack {
                    Text("If you already have an account,")
                    // زر "Log In" ينقلك إلى صفحة أخرى
                    NavigationLink(destination: LoginView()) {
                        Text("Log In")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 20)

            }
            .padding()
        }
    }

    func signup(email: String, password: String) {
        guard let url = URL(string: "https://api2.smartinb.ai/api/auth/signup?databaseName=kai") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    showMessage = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            if let data = data, let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 201 {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let token = jsonResponse["token"] as? String {
                            DispatchQueue.main.async {
                                showMessage = "User registered successfully! Token: \(token)"
                            }
                        } else {
                            DispatchQueue.main.async {
                                showMessage = "User registered, but no token received."
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            showMessage = "Failed to parse response."
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        showMessage = "Failed to register. Status code: \(httpResponse.statusCode)"
                    }
                }
            }
        }.resume()
    }
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}


