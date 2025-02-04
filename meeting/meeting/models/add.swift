import SwiftUI

struct AddMeetingView: View {
    @State private var title: String = ""
    @State private var name: String = ""
    @State private var room: String = ""
    @State private var selectDate: Date = Date()
    @State private var selectTime: Date = Date()
    @State private var description: String = ""
    @State private var agreedToTerms: Bool = false // State for the checkbox
    
    var body: some View {
        NavigationView {
            
            VStack {
               
                Text("Make a Reservation")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(.trailing,60)
               
                Divider()
                    .frame(width: 350)
                
                VStack(alignment: .leading, spacing: 10) {
                    // Title
                    Text("Title")
                        .foregroundColor(.black)
                    TextField("Enter meeting title", text: $title)
                        .padding(.all,10)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                    
                    // Name
                    Text("Name")
                        .foregroundColor(.black)
                    TextField("Enter your name", text: $name)
                        .padding(.all,10)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                    
                    // Room
                    Text("Room")
                        .foregroundColor(.black)
                    TextField("Enter room number", text: $room)
                        .padding(.all,10)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                   
                    VStack(alignment:.leading, spacing: 10) {
                        // Select Date
                        Text("Select Date")
                            .foregroundColor(.black)
                        DatePicker("Select a date", selection: $selectDate, displayedComponents: .date)
                            .padding(.all,10)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                        
                        // Select Time
                        Text("Select Time")
                            .foregroundColor(.black)
                        DatePicker("Select a time", selection: $selectTime, displayedComponents: .hourAndMinute)
                            .padding(.all,10)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                        
                        // Description
                        Text("Description")
                            .foregroundColor(.black)
                        TextField("Enter description", text: $description)
                            .padding(.all,10)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                        
                        // Checkbox for Terms of Use
                        Toggle(isOn: $agreedToTerms) {
                            Text("I agree to the Terms of Use")
                                .foregroundColor(.black)
                        }
                        .toggleStyle(CheckboxToggleStyle()) // Custom checkbox style
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
                    }
                }
                
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarItems(trailing:
                                    Text("Get My Meeting")
                                        .font(.system(size: 24))
                                        .fontWeight(.bold)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
            )
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

struct AddMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        AddMeetingView()
    }
}

