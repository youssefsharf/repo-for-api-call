import SwiftUI

struct HomeView: View {
    @State private var search: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                // حقل البحث والزر على شكل أيقونة
                VStack {
                    HStack {
                        // زر على شكل أيقونة بحث
                        Button(action: {
                            print("Search button tapped")
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .font(.system(size: 24)) // ضبط حجم الأيقونة
                                .frame(width: 55, height: 55)
                                .background(Color.accentColor) // لون الخلفية
                                .cornerRadius(10) // حواف مستديرة للزر
                        }
                        .padding(.trailing, 10) // تباعد بين الزر وحقل البحث
                        
                        // حقل البحث
                        TextField("Search...", text: $search)
                            .padding(.horizontal)
                            .frame(height: 55)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20) // إضافة تباعد حول الـ HStack بأكمله
                    .padding(.top, 20)
                }
                
                // زر لا توجد حجوزات جديدة
                Button(action: {
                    print("No new reservations button tapped")
                }) {
                    Text("No new reservations, click to create")
                        .foregroundColor(.blue)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 300)
                
                Spacer()
                
                // الأزرار في أسفل الشاشة
                HStack {
                    Spacer()
                    
                    VStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue)
                            .font(.system(size: 24)
                                  )
                            
                        Text("Back")
                            .foregroundColor(.blue)
                           
                            .font(.footnote)
                    }
                    
                    Spacer()     // زر إضافة اجتماع جديد
                    NavigationLink(destination: AddMeetingView()) {
                        VStack {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                            Text("Add")
                                .font(.footnote)
                        }
                    }
                  // إضافة تباعد بين الأزرار
                    
                    // زر الإضافة (زر غير وظيفي حاليًا)
                  
                    Spacer() // إضافة تباعد بين الأزرار
                    
                    // زر إضافة شخص
                    Button(action: {
                        print("Add person button tapped")
                    }) {
                        VStack {
                            Image(systemName: "person.badge.plus")
                                .font(.system(size: 24))
                            Text("Add Person")
                                .font(.footnote)
                        }
                    }
                    
                    Spacer() // إضافة تباعد بين الأزرار
                    
                    // زر الصفحة الرئيسية
                    Button(action: {
                        print("Home button tapped")
                    }) {
                        VStack {
                            Image(systemName: "house.fill")
                                .font(.system(size: 24))
                            Text("Home")
                                .font(.footnote)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 30) // إضافة تباعد من أسفل الشاشة
            }
            .toolbar {
                ToolbarItem() {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Welcome Back")
                                .fontWeight(.bold)  // جعل النص رئيسي أكثر
                                .foregroundColor(.primary)
                            Text("We're glad to see you again!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 40)
                        
                        // صورة
                        Image("Image-1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .padding(.horizontal, 30) // جعل الصورة دائرية
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 30)
                }
            }
        }
    }
}

// صفحة إضافة اجتماع جديد


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

