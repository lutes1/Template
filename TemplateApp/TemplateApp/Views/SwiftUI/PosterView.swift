//
//  PosterView.swift
//  TemplateApp
//
//  Created by Petru Lutenco on 18.04.2024.
//

import SwiftUI
import Domain
import NukeUI

struct PosterView: View {
    
    let movie: Movie
    var body: some View {
        LazyImage(url: URL(optionalString: movie.posterPath)) { imagePhase in
            if let image = imagePhase.image {
                image
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fill)
            } else if imagePhase.isLoading {
                ProgressView()
                    .expanded()
            } else {
                Image(systemName: "xmark.circle")
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .mask(
            LinearGradient(
                colors: [
                    .black.opacity(0.8),
                    .clear
                ],
                startPoint: .init(x: 0, y: 0.6),
                endPoint: .init(x: 0, y: 1)
            )
        )
        .overlay(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.system(size: 28))
                    .fontWeight(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let date = movie.releaseDate {
                    Text("Release date: \(date.toString(formatterType: .longMonthDayTime))")
                        .font(.system(size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.bold)
                }
            }
            .shadow(color: .black.opacity(0.2), radius: 1)
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PosterView(
        movie: .init(
            id: 0,
            title: "Some title",
            posterPath: "https://image.tmdb.org/t/p/original/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg",
            overview: "This is the overview",
            releaseDate: .now,
            popularity: 1,
            voteAverage: 1,
            voteCount: 1
        )
    )
}
