import SwiftUI

struct nav: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer() // يضع كل المحتوى في الأعلى ويترك باقي المساحة في الأسفل

                
                //Text("Content here")
                
                Spacer() // يجعل المساحة في الأعلى والأسفل متساوية
                
                // الأزرار في أسفل الشاشة وفي المنتصف
                HStack {
                    Spacer() // تباعد من اليسار

                    Button(action: {
                        print("Back button tapped")
                    }) {
                        Image(systemName: "arrow.left")
                    }

                    Spacer() // تباعد بين الأزرار

                    Button(action: {
                        print("Add button tapped")
                    }) {
                        Image(systemName: "plus")
                    }

                    Spacer() // تباعد من اليمين
                }
                .padding(.bottom, 30) // إضافة تباعد من أسفل الشاشة
            }
            .navigationTitle("My Title") // عنوان شريط التنقل
        }
    }
}

struct nav_Previews: PreviewProvider {
    static var previews: some View {
        nav()
    }
}
