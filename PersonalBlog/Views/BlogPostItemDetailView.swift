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
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    
                    Text(model.title)
                        .bold()
                        .font(.title)
                        .frame(alignment: .top)
                        .padding()
                    
                    let imageSize: CGFloat = proxy.frame(in: .global).width/1.5
                    
                    AsyncImage(url: URL(string: model.postUrlString)) { image in
                        image.image?.resizable()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize, height: imageSize)
                    .clipped()
                    
                    Text(model.body)
                        .padding()
                    
                    HStack {
                        Spacer()
                        
                        AsyncImage(url: userProfileImage) { image in
                            image.image?.resizable()
                        }
                        .frame(width: 75, height: 75, alignment: .leading)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        
                        Text(user.name)
                            .bold()
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle(model.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    BlogPostItemDetailView(model: BlogPost(id: "123", title: "Title", postedDate: "123", body: "He has changed drastically from being the very strict 'White-haired Devil' to the 'White-haired Buddha' with a lighter personality, probably because of Yazawa's demise. Sakuragi always calls him, 'Oyaji' (old man) and has the habit of jiggling the fat in his chin and belly whenever he's hyped, which makes the others, Mitsui in particular mad at him, as that is considered disrespectful. However, Anzai appears to tolerate this and has not reprimanded Sakuragi for his behavior. Anzai did punish the 4 players (Mitsui, Miyagi, Sakuragi, and Rukawa) who are involved in the fight against Mitsui's gang by keeping them on the bench during the first Inter High game against Miuradai High School.He is also a very charismatic person, as he gave Mitsui the confidence to never give up until the match is really over, which enabled Mitsui to win the match in his middle school days and join Shohoku because of Anzai's inspiring words. He even motivated Rukawa and inspired him to become the number 1 basketball player. He even motivated Sakuragi in practicing 20 000 jump shots, and was also responsible for Sakuragi's determination and resolve during the match against Sannoh, as Sakuragi thanked him and told him that he was finally able to change the game to be decisive needed thanks to his words.When Akagi, Mitsui, Miyagi, Kogure and Rukawa are having a school camp in Shizuoka, Anzai trains Sakuragi in how to make a jump shot similar to a 3-point shot as he tells him to make a 20,000 shots which he successfully does with the assistance of Sakuragi's gang and as part of the camp. This training that Anzai makes is a favor after Sakuragi rescued him on time when he suffers a heart attack.https://slamdunk.fandom.com/wiki/Mitsuyoshi_Anzai", postUrlString: "https://firebasestorage.googleapis.com:443/v0/b/personalblog-60038.appspot.com/o/Anzai%2Fposts%2FAnzai_751_1699093720.167636.png?alt=media&token=bd7da551-1265-4b00-8532-8724e0bbece9", likers: []), user: User(name: "Username", email: "userEmail"), userProfileImage: URL(string: "https://firebasestorage.googleapis.com/v0/b/personalblog-60038.appspot.com/o/Anzai%2Fprofile_picture.png?alt=media&token=603b2589-1972-4a63-bd6f-3bcb9a35f0da"))
}
