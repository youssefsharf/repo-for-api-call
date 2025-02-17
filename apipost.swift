import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showMessage: String = ""
    
    // متغيرات لتخزين الاسم والتوكن
    @State private var token: String = ""
    @State private var name: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Login") {
                    login(email: email, password: password)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                if !showMessage.isEmpty {
                    Text(showMessage)
                        .padding()
                        .foregroundColor(showMessage.contains("success") ? .green : .red)
                }
                
                // عرض الجدول إذا كان هناك بيانات
                if !token.isEmpty && !name.isEmpty {
                    VStack(alignment: .leading) {
                        Text("User Details")
                            .font(.headline)
                            .padding(.top)
                        
                        List {
                            HStack {
                                Text("Token")
                                Spacer()
                                Text(token)
                            }
                            HStack {
                                Text("id")
                                Spacer()
                                Text(name)
                            }
                        }
                        .frame(height: 100) // تحديد ارتفاع الجدول
                    }
                    .padding()
                }
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
                
                if let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                           let token = jsonResponse["token"] as? String,
                           let dataDict = jsonResponse["data"] as? [String: Any] {
                            
                            // تخزين التوكن والاسم
                            self.token = token
                            self.name = dataDict["name"] as? String ?? "No name"
                            
                            // تحليل البيانات الأساسية
                            let id = dataDict["_id"] as? String ?? "No ID"
                            let email = dataDict["email"] as? String ?? "No email"
                            let sex = dataDict["sex"] as? String ?? "No sex"
                            let wishlist = dataDict["wishlist"] as? [String] ?? []
                            let isCustomer = dataDict["isCustomer"] as? Bool ?? false
                            let iban = dataDict["iban"] as? [Any] ?? []
                            let cards = dataDict["cards"] as? [Any] ?? []
                            let createdAt = dataDict["createdAt"] as? String ?? "No creation date"
                            let updatedAt = dataDict["updatedAt"] as? String ?? "No update date"
                            let v = dataDict["__v"] as? Int ?? 0
                            let idNumber = dataDict["idNumber"] as? Int ?? 0
                            let phoneNumber = dataDict["phoneNumber"] as? String ?? "No phone number"
                            let birthDate = dataDict["birthData"] as? String ?? "No birth date"
                            let country = dataDict["country"] as? String ?? "No country"

                            // عرض النتيجة
                            showMessage = """
                            Login successful!
                            Token: \(token)
                            ID: \(id)
                            Email: \(email)
                            Sex: \(sex)
                            Wishlist: \(wishlist)
                            isCustomer: \(isCustomer)
                            IBAN: \(iban)
                            Cards: \(cards)
                            Created At: \(createdAt)
                            Updated At: \(updatedAt)
                            Version: \(v)
                            ID Number: \(idNumber)
                            Name: \(name)
                            Phone Number: \(phoneNumber)
                            Birth Date: \(birthDate)
                            Country: \(country)
                            """
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
