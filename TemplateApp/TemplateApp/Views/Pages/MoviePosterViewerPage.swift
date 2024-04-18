//
//  MoviePosterViewerPage.swift
//  TemplateApp
//
//  Created by Petru Lutenco on 18.04.2024.
//

import SwiftUI
import NukeUI

struct MoviePosterViewerPage: View {
    let posterPath: String
    @State var aspectFit: ContentMode = .fill
    
    var body: some View {
        LazyImage(url: URL(optionalString: posterPath)) { imagePhase in
            if let image = imagePhase.image {
                image
                    .resizable()
                    .expanded()
                    .aspectRatio(contentMode: aspectFit)
                    .ignoresSafeArea()
            } else if imagePhase.isLoading {
                ProgressView()
                    .expanded()
            } else {
                Image(systemName: "xmark.circle")
            }
        }
        .gesture(TapGesture(count: 2).onEnded {
            withAnimation {
                aspectFit = aspectFit == .fill ? .fit : .fill
            }
        })
    }
}

#Preview {
    MoviePosterViewerPage(posterPath: "https://image.tmdb.org/t/p/original/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg")
}
