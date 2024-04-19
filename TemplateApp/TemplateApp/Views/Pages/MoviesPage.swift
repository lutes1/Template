//
//  MoviesPage.swift
//  Template
//
//  Created by Petru Lutenco on 11.04.2024.
//

import SwiftUI
import Core
import Shared
import NukeUI
import Domain

struct MoviesPage: View {
    @State var viewModel: MoviesViewModelProtocol
    @FocusState var _isSearchFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(
                "Search...",
                text: $viewModel.query
            )
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .focused($_isSearchFocused)
            .overlay(alignment: .trailing) {
                if !viewModel.query.isEmpty {
                    Button {
                        viewModel.query = ""
                        viewModel.mode = .discover
                        _isSearchFocused = false
                    } label: {
                        Circle()
                            .fill(.gray.opacity(0.8))
                            .frame(width: 20)
                            .overlay {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .bold()
                                    .padding(6)
                            }
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(.horizontal)
            .tag("searchField")
            
            PageContents(pageState: viewModel.pageState) {
                if !viewModel.items.isEmpty {
                    List {
                        ForEach(viewModel.items) { item in
                            Button {
                                viewModel.onMovieSelected(movie: item)
                            } label: {
                                _movieItem(movie: item)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init())
                        
                        if viewModel.canLoadMoreItems {
                            ProgressView()
                                .id(UUID())
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height: 50)
                                .onAppear {
                                    Task {
                                        await viewModel.loadResultsPage()
                                    }
                                }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .scrollDismissesKeyboard(.immediately)
                    .safeAreaPadding(.vertical, 8)
                    .listStyle(.plain)
                } else {
                    VStack {
                        
                        Spacer()
                        
                        Text("No movie was found for the searched term \(viewModel.query)")
                            .font(.system(size: 14))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                        
                        Spacer()
                    }
                }
            }
        }
        .expanded()
        .onChange(of: _isSearchFocused, initial: false) { _, newValue in
            if newValue {
                viewModel.mode = .search
            }
        }
        .onChange(of: viewModel.query, initial: false) { _, newValue in
            if newValue.isEmpty {
                viewModel.mode = .discover
            } else if viewModel.mode == .discover {
                viewModel.mode = .search
            }
        }
        .task {
            await viewModel.loadResultsPage()
        }
    }
    
    @MainActor
    private func _movieItem(movie: Movie) -> some View {
        VStack {
            PosterView(movie: movie)
            
            Text(movie.overview)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .bottom])
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 10)
        .padding()
    }
}

#Preview {
    MoviesPage(
        viewModel: DIContainer.shared.resolveMock(
            MoviesViewModelProtocol.self
        )
    )
}
