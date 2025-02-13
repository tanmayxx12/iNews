//
//  ArticleRowView.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        
        VStack{
            AsyncImage(url: article.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } placeholder: {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .frame(minHeight: 200, maxHeight: 320)
        .background(.gray.opacity(0.3))
        .padding(.bottom)
        
        VStack(alignment: .leading, spacing: 8) {
            Text("\(article.title)")
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(3)
            
            Text("\(article.descriptionText)")
                .font(.subheadline)
                .lineLimit(2)
        }
        .padding([.horizontal, .bottom])
        
        HStack {
            Text("\(article.captionText)")
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                
            Spacer()
            
            // Bookmark Button:
            Button {
                // ACtion for when the button is tapped:
            } label: {
                Image(systemName: "bookmark")
            }
            .buttonStyle(.bordered)
            
            // Share button:
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
            .buttonStyle(.bordered)
                
        }
        .padding(.horizontal)
    }
}

#Preview {
    List {
        ArticleRowView(article: .previewData[0])
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    .listStyle(.plain)
    
}
