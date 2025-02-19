import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showMessage: String = ""
    
    // متغيرات لتخزين الاسم والتوكن
    @State private var token: String = ""
    @State private var name: String = ""
    @State private var navigateTologin: Bool = false // متغير للتحكم في الانتقال

    var body: some View {
        NavigationStack {
            VStack {
                // إضافة صورة فوق النص "Welcome"
                Image("1") // قم بتغيير "1" إلى اسم الصورة الخاصة بك
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
                    // قم بتنفيذ عملية تسجيل الدخول
                    login(email: email, password: password)
                }) {
                    Text("Sign in")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 50)

                if !showMessage.isEmpty {
                    Text(showMessage)
                        .padding()
                        .foregroundColor(showMessage.contains("success") ? .green : .red)
                }

                // NavigationLink مخفي للانتقال إلى ContentView
                NavigationLink(destination: ContentView(), isActive: $navigateTologin) {
                    EmptyView() // هذا يجعل NavigationLink غير مرئي
                }
                Spacer()
            }
            .padding()
        }
    }

    func login(email: String, password: String) {
        guard let url = URL(string: "https://api2.smartinb.ai/api/auth/ecommerce-login?databaseName=kai") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email.lowercased(), "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    showMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                if let data = data, let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                           let token = jsonResponse["token"] as? String,
                           let dataDict = jsonResponse["data"] as? [String: Any] {
                            
                            // تخزين التوكن والاسم
                            self.token = token
                            self.name = dataDict["name"] as? String ?? "No name"
                            
                            // تحليل البيانات باستخدام الدالة الجديدة
                            let userData = parseUserData(from: dataDict)
                            
                            // عرض النتيجة
                            showMessage = """
                            Login successful!
                            Token: \(token)
                            ID: \(userData.id)
                            Email: \(userData.email)
                            Sex: \(userData.sex)
                            Wishlist: \(userData.wishlist)
                            isCustomer: \(userData.isCustomer)
                            IBAN: \(userData.iban)
                            Cards: \(userData.cards)
                            Created At: \(userData.createdAt)
                            Updated At: \(userData.updatedAt)
                            Version: \(userData.v)
                            ID Number: \(userData.idNumber)
                            Name: \(name)
                            Phone Number: \(userData.phoneNumber)
                            Birth Date: \(userData.birthDate)
                            Country: \(userData.country)
                            """
                            
                            // الانتقال إلى الصفحة التالية بعد نجاح تسجيل الدخول
                            navigateTologin = true
                        } else {
                            showMessage = "Login successful, but no token or data received."
                        }
                    } catch {
                        showMessage = "Failed to parse response."
                    }
                } else {
                    showMessage = "Failed to login. Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)"
                }
            }
        }.resume()
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
