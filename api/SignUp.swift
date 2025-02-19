import SwiftUI

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showMessage: String = ""
    @State private var navigateToSignUp: Bool = false // حالة التنقل

    var body: some View {
        NavigationStack {
            VStack {
                // إضافة صورة فوق النص "Welcome"
                Image("1") // قم بتغيير "logo" إلى اسم الصورة الخاصة بك
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 300)
                    .padding(.bottom, 20)

                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                // حقل الإيميل مع أيقونة
                HStack {
                    Image(systemName: "envelope") // أيقونة الإيميل
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                    TextField("Email", text: $email)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                // حقل كلمة المرور مع أيقونة
                HStack {
                    Image(systemName: "lock") // أيقونة كلمة المرور
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                    SecureField("Password", text: $password)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                Button(action: {
                    // قم بتنفيذ أي عمليات تسجيل هنا
                    signup(email: email, password: password)
                }) {
                    Text("Sign Up")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)

                HStack {
                    Text("If you already have an account,")
                    NavigationLink(destination: LoginView()) {
                        Text("Log In")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top , 25)

                // NavigationLink مخفي للانتقال إلى ContentView
                NavigationLink(destination: ContentView(), isActive: $navigateToSignUp) {
                }
            }
            Spacer()
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
                    DispatchQueue.main.async {
                        navigateToSignUp = true // تنشيط التنقل عند نجاح التسجيل
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
