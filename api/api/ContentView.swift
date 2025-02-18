//
//  ContentView.swift
//  fff
//
//  Created by MacBook Air on 2/12/25.
//
import SwiftUI

struct ContentView: View {
    @State private var company: String = ""  // Holds the entered username
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Name")
                    .fontWeight(.semibold) // جعل النص أكثر وضوحًا
                
                TextField("Type your GitHub username", text: $company)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .onChange(of: company) { newValue in
                        company = newValue.lowercased() // تحويل النص المدخل إلى أحرف صغيرة
                    }
                
                NavigationLink(destination: Api(username: company)) {  // Passing company to Api view
                    Text("Search")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
}

