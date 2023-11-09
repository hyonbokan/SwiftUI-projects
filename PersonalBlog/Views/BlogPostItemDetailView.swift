//
//  BlogPostItemDetailView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/8/23.
//

import SwiftUI

struct BlogPostItemDetailView: View {
    let model: BlogPost
    let user: User
    let userProfileImage: URL?
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical) {
                titleView(title: model.title)
                
                imageView(with: model.postUrlString).padding()
                
                bodyTextView(text: model.body)
                
                userInfoView(imageURL: userProfileImage ?? URL(string: "")!, userName: user.name)
            }
        }
        .navigationTitle(model.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Button(action: didTapLike) {
                    Image(systemName: "basketball")
                        .font(.system(size: 15))
                        .foregroundColor(.purple)
                }
                Button(action: didTapLike) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 15))
                        .foregroundColor(.purple)
                }
            }
        }
    }

    func didTapLike() {
        print("did tap like")
    }
    
    @ViewBuilder
    func titleView(title: String) -> some View {
        HStack {
            Text(title)
                .bold()
                .font(.title)
                .padding()
            Spacer()
        }
    }
    
    @ViewBuilder
    func imageView(with urlString: String) -> some View {
            let imageSize: CGFloat = UIScreen.main.bounds.width / 1.5
            AsyncImage(url: URL(string: urlString)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageSize)
                        .clipped()
                case .failure:
                    Color.red
                case .empty:
                    ProfileView()
                @unknown default:
                    EmptyView()
                }
            }
        .frame(maxWidth: .infinity, maxHeight: 230, alignment: .center)
    }
    
    @ViewBuilder
    func bodyTextView(text: String) -> some View {
        Text(text)
            .padding()
    }
    
    @ViewBuilder
    func userInfoView(imageURL: URL, userName: String) -> some View {
        HStack {
            AsyncImage(url: imageURL) { image in
                image.image?.resizable()
            }
            .frame(width: 75, height: 75)
            .clipShape(Circle())
            
            Text(userName)
                .bold()
                .padding(.leading, 5)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func actionButtons() -> some View {
        HStack {
            Button(action: didTapLike) {
                Image(systemName: "basketball")
                    .font(.system(size: 20))
                    .foregroundColor(.purple)
            }
            .frame(width: 50, height: 40)
            
            Button(action: didTapLike) {
                Image(systemName: "paperplane")
                    .font(.system(size: 20))
                    .foregroundColor(.purple)
            }
            .frame(width: 50, height: 40)
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.purple, lineWidth: 1)
        )
        Spacer()
    }
}

#Preview {
    BlogPostItemDetailView(model: BlogPost(id: "123", title: "Title", postedDate: "123", body: "He has changed drastically from being the very strict 'White-haired Devil' to the 'White-haired Buddha' with a lighter personality, probably because of Yazawa's demise. Sakuragi always calls him, 'Oyaji' (old man) and has the habit of jiggling the fat in his chin and belly whenever he's hyped, which makes the others, Mitsui in particular mad at him, as that is considered disrespectful. However, Anzai appears to tolerate this and has not reprimanded Sakuragi for his behavior. Anzai did punish the 4 players (Mitsui, Miyagi, Sakuragi, and Rukawa) who are involved in the fight against Mitsui's gang by keeping them on the bench during the first Inter High game against Miuradai High School.He is also a very charismatic person, as he gave Mitsui the confidence to never give up until the match is really over, which enabled Mitsui to win the match in his middle school days and join Shohoku because of Anzai's inspiring words. He even motivated Rukawa and inspired him to become the number 1 basketball player. He even motivated Sakuragi in practicing 20 000 jump shots, and was also responsible for Sakuragi's determination and resolve during the match against Sannoh, as Sakuragi thanked him and told him that he was finally able to change the game to be decisive needed thanks to his words.When Akagi, Mitsui, Miyagi, Kogure and Rukawa are having a school camp in Shizuoka, Anzai trains Sakuragi in how to make a jump shot similar to a 3-point shot as he tells him to make a 20,000 shots which he successfully does with the assistance of Sakuragi's gang and as part of the camp. This training that Anzai makes is a favor after Sakuragi rescued him on time when he suffers a heart attack.https://slamdunk.fandom.com/wiki/Mitsuyoshi_Anzai", postUrlString: "https://firebasestorage.googleapis.com:443/v0/b/personalblog-60038.appspot.com/o/Anzai%2Fposts%2FAnzai_751_1699093720.167636.png?alt=media&token=bd7da551-1265-4b00-8532-8724e0bbece9", likers: []), user: User(name: "Username", email: "userEmail"), userProfileImage: URL(string: "https://firebasestorage.googleapis.com/v0/b/personalblog-60038.appspot.com/o/Anzai%2Fprofile_picture.png?alt=media&token=603b2589-1972-4a63-bd6f-3bcb9a35f0da"))
}
