import SwiftUI
struct UserData {
    let id: String
    let email: String
    let sex: String
    let wishlist: [String]
    let isCustomer: Bool
    let iban: [Any]
    let cards: [Any]
    let createdAt: String
    let updatedAt: String
    let v: Int
    let idNumber: Int
    let phoneNumber: String
    let birthDate: String
    let country: String
}
struct Api: View {
    let username: String  // The username passed from ContentView

    @State private var user: GitHubUser?
    @State private var errorMessage: String?  // To handle errors

    var body: some View {
        VStack(spacing: 20) {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            if let user = user {
                AsyncImage(url: URL(string: user.avatarUrl)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    } else if phase.error != nil {
                        Circle()
                            .foregroundColor(.secondary)
                    } else {
                        Circle()
                            .foregroundColor(.secondary)
                    }
                }
                .frame(width: 120, height: 120)
                
                Text(user.login)
                    .bold()
                    .font(.title3)
                
                Text(user.bio ?? "No bio available")
                    .padding()
            } else {
                Text("Loading...")
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .task {
            await fetchUserData()
        }
    }
    
    func fetchUserData() async {
        guard !username.isEmpty else {
            errorMessage = "Username cannot be empty."
            return
        }
        
        let endpoint = "https://api.github.com/users/\(username)"
        guard let url = URL(string: endpoint) else {
            errorMessage = "Invalid URL."
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                errorMessage = "User not found."
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            user = try decoder.decode(GitHubUser.self, from: data)
        } catch {
            errorMessage = "Failed to load data."
        }
    }
}

struct Api_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String?
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}



func parseUserData(from dataDict: [String: Any]) -> UserData {
    return UserData(
        id: dataDict["_id"] as? String ?? "No ID",
        email: dataDict["email"] as? String ?? "No email",
        sex: dataDict["sex"] as? String ?? "No sex",
        wishlist: dataDict["wishlist"] as? [String] ?? [],
        isCustomer: dataDict["isCustomer"] as? Bool ?? false,
        iban: dataDict["iban"] as? [Any] ?? [],
        cards: dataDict["cards"] as? [Any] ?? [],
        createdAt: dataDict["createdAt"] as? String ?? "No creation date",
        updatedAt: dataDict["updatedAt"] as? String ?? "No update date",
        v: dataDict["__v"] as? Int ?? 0,
        idNumber: dataDict["idNumber"] as? Int ?? 0,
        phoneNumber: dataDict["phoneNumber"] as? String ?? "No phone number",
        birthDate: dataDict["birthData"] as? String ?? "No birth date",
        country: dataDict["country"] as? String ?? "No country"
    )
}
