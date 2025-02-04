//
//  sign up.swift
//  meeting
//
//  Created by MacBook Air on 1/22/25.
//

import SwiftUI

struct sign_up: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fullname: String = ""
    @State private var company: String = ""
    var body: some View {
        NavigationView{
            
            VStack {
           
            Image("Image-1") // اسم الصورة في مجلد Assets
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 150) // تعديل حجم الصورة لتناسب المساحة
            
                .navigationBarTitle("") // إخفاء العنوان الافتراضي
                .navigationBarHidden(false)

            VStack(alignment: .center, spacing: 12) {
                Text("Full Name")
                    .fontWeight(.semibold) // جعل النص أكثر وضوحًا
                TextField("Type your email here...", text: $fullname)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                Text("Company")
                    .fontWeight(.semibold) // جعل النص أكثر وضوحًا
                TextField("Type your email here...", text: $company)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                Text("Email")
                    .fontWeight(.semibold) // جعل النص أكثر وضوحًا
                TextField("Type your email here...", text: $email)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                Text("Password")
                    .fontWeight(.semibold) // جعل النص أكثر وضوحًا
                SecureField("Type your password here...", text: $password)
                    .padding(.horizontal)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 1) // إضافة تباعد داخلي حول حقول النص
            
            Button(action: {
                print("Login button tapped")
            }) {
                Text("Sign up".uppercased())
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .padding(.top, 20) // إضافة تباعد أعلى الزر
            }
                HStack {
                    Text(".")
                    NavigationLink(destination: terms()) {
                        Text("Terms of Use")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    Text("By registering,you accept the")
                }
                
                     .padding(.top, 10)
                HStack {
                    Text("it now.")
                    NavigationLink(destination: ContentView()) {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    Text("Forget your password?")
                }
                .padding(.top, 10)
                Spacer()
        }
            
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .toolbar { // استخدام toolbar لإضافة النص والخط الأفقي في شريط التنقل
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Signup") // النص في شريط التنقل
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Divider() // الخط الأفقي تحت النص
                            .frame(width: 300)
                    }
                }
            }
        }
    }
}

struct sign_upPreview: PreviewProvider {
    static var previews: some View {
        sign_up()
    }
}

