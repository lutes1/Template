//
//  MovieDetails.swift
//  TemplateApp
//
//  Created by Petru Lutenco on 18.04.2024.
//

import SwiftUI
import Core
import Shared
import NukeUI

struct MovieDetails: View {
    
    @State var viewModel: MovieDetailsViewModelProtocol
    
    var body: some View {
        VStack(spacing: 0) {
            PosterView(movie: viewModel.movie)
                .onLongPressGesture {
                    if let path = viewModel.movie.posterPath {
                        viewModel.openFullResolutionImage(url: path)
                    }
                }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Rating")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        HStack {
                            Text(String(viewModel.movie.voteAverage))
                                .font(.system(size: 28))
                                .fontWeight(.black)
                            
                            HStack {
                                Text("(Votes \(viewModel.movie.voteCount))")
                                    .font(.system(size: 12))
                                    .fontWeight(.light)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Popularity")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text(String(viewModel.movie.popularity))
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Overview")
                            .fontWeight(.light)
                        
                        Text(viewModel.movie.overview)
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

#Preview {
    MovieDetails(
        viewModel: DIContainer.shared.resolveMock(
            MovieDetailsViewModelProtocol.self
        )
    )
}
