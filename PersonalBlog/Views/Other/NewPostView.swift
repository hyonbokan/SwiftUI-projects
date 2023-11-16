//
//  NewPostView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/16/23.
//
import PhotosUI
import SwiftUI

struct NewPostView: View {
//    @State var selectedItems: [PhotosPickerItem] = []
    @StateObject var viewModel = NewPostViewViewModel()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Form {
                PhotosPicker(selection: $viewModel.selectedItems,
                             maxSelectionCount: 1,
                             matching: .images) {
                    if let data = viewModel.data, let uiimage = UIImage(data: data) {
                        Image(uiImage: uiimage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .padding()
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundStyle(.purple)
                            .frame(height: 200)
                            .padding()
                    }
                    
                }
                             .onChange(of: viewModel.selectedItems) {
                                 [weak viewModel] newValue in
                                 guard let item = viewModel?.selectedItems.first else {
                                     return
                                 }
                                 item.loadTransferable(type: Data.self) { result in
                                    switch result {
                                    case .success(let data):
                                        if let data = data {
                                            DispatchQueue.main.async {
                                                viewModel?.data = data
                                            }
                                        } else {
                                            print("Data is nil")
                                        }
                                    case .failure(let error):
                                        fatalError("\(error)")
                                     }
                                 }
                             }
                
                TextField("Title for the post", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TextEditor(text: $viewModel.text)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .frame(height: 250)
                
            }
        }
    }
}

#Preview {
    NewPostView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
