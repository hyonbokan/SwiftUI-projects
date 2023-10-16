//
//  AirbnbDetailView.swift
//  Airbnb
//
//  Created by Michael Kan on 2023/10/15.
//

import SwiftUI

struct AirbnbDetailView: View {
    let model: AirbnbListing
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    // Picture
                    AsyncImage(url: URL(string: model.xl_picture_url ?? ""))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: proxy.frame(in: .global).width, height: proxy.frame(in: .global).width)
                        .clipped()
                    
                    // Info
                    Text(model.name ?? "")
                        .bold()
                        .padding()
                    
                    if let price = model.price {
                        Text("Rate: \(price.formatted(.currency(code: "USD")))")
                    }
                    
                    
                    Text("Description: \(model.description ?? "")")
                        .padding()
                    Text("Summary: \(model.summary ?? "")")
                        .padding()
                    Text("Rules: \(model.house_rules ?? "The owner did not specify")")
                        .padding()
                    Text("Space: \(model.space ?? "")")
                        .padding()
                    
                    // Host Info
                    Text("About Your Host")
                        .font(.title2)
                        .bold()
                    HStack {
                        AsyncImage(url: URL(string: model.host_picture_url))
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                        
                        Text(model.host_name)
                            .bold()
                    }
                    .padding()
                    
                    Text("Hosting since: \(model.host_since)")
                        .font(.footnote)
                }
                .frame(maxWidth: proxy.frame(in: .global).width)
            }
        }
        .navigationTitle(model.name ?? "Listring")
        .navigationBarTitleDisplayMode(.inline)
    }
}

