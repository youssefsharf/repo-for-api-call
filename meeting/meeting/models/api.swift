import SwiftUI

struct api: View {
    @State private var user: GitHubUser?
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { phase in
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
            
            Text(user?.login ?? "Login Placeholder")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "Bio Placeholder")
                .padding()
            
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await; getUser()
            } catch GHError.invalidURL {
                print("invalid URL")
            } catch GHError.invalidResponse {
                print("invalid Response")
            } catch GHError.invalidData {
                print("invalid Data")
            } catch {
                print("unexpected error")
            }
        }
    }
    
    // دالة `getUser` يجب أن تكون خارج `body`
    func getUser(); async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/youssef" // تأكد من أن الرابط صحيح
        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}

struct api_Previews: PreviewProvider {
    static var previews: some View {
        api()
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
