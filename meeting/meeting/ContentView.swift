import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showResetOverlay = false // لإظهار الـ Overlay
    @State private var resetEmail = "" // حقل البريد الإلكتروني لإعادة التعيين

    var body: some View {
        ZStack {
            // المحتوى الرئيسي
            NavigationView {
                VStack {
                    Image("Image-1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150) // تعديل حجم الصورة
                    
                    VStack(alignment: .center, spacing: 12) {
                        Text("Email")
                            .fontWeight(.semibold)
                        TextField("Type your email here...", text: $email)
                            .padding(.horizontal)
                            .frame(height: 55)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                        
                        Text("Password")
                            .fontWeight(.semibold)
                        SecureField("Type your password here...", text: $password)
                            .padding(.horizontal)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 1)
                    
                    Button(action: {
                        print("Login button tapped")
                    }) {
                        Text("Login".uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                            .padding(.top, 20)
                    }
                    
                    HStack {
                        Text("now.")
                        NavigationLink(destination: sign_up()) {
                            Text("Sign up")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                        Text("Don't have an account?")
                    }
                    .padding(.top, 10)
                    
                    HStack {
                        Text("it now.")
                        Button(action: {
                            // عرض الـ Overlay عند الضغط على زر "Reset"
                            showResetOverlay = true
                        }) {
                            Text("Reset")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                        Text("Forget your password?")
                    }
                    .padding(.top, 10)
                    
                    Spacer() // يضيف مساحة في الأسفل لتثبيت المحتوى في الأعلى
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .toolbar { // استخدام toolbar لإضافة النص والخط الأفقي في شريط التنقل
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Login") // النص في شريط التنقل
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Divider() // الخط الأفقي تحت النص
                                .frame(width: 300)
                        }
                    }
                }
            }
            
            // Overlay عند ظهور الـ Reset
            if showResetOverlay {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all) // يجعل الخلفية تغطي الشاشة بالكامل

                VStack(spacing: 20) {
                    Text("Reset Password")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    TextField("Enter your email", text: $resetEmail)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal, 40) // تحكم في عرض مربع النص
                    
                    HStack {
                        Button("Cancel") {
                            // إغلاق الـ overlay
                            showResetOverlay = false
                        }
                        .padding()
                        .foregroundColor(.black)

                        Spacer()

                        Button("OK") {
                            // معالجة إعادة التعيين
                            print("Reset email sent to: \(resetEmail)")
                            showResetOverlay = false
                        }
                        .padding()
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal, 40)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .frame(maxWidth: .infinity, maxHeight: 300) // التحكم في حجم الـ Overlay
                .padding(.horizontal, 40) // التحكم في عرض الـ Overlay
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

